#!/usr/bin/env bash
set -euo pipefail

# ============================================================================
# Cognitive Base Installer — Unified installer for AI coding agents
# Supports: Claude Code, Gemini CLI, Codex CLI, Cursor, OpenCode, OpenClaw
# ============================================================================

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BASE_NAME="$(basename "$SCRIPT_DIR")"
PROTOCOL_FILE="$SCRIPT_DIR/cognitive-protocol.md"
BASE_TITLE="$(head -1 "$PROTOCOL_FILE" | sed 's/^# //' | sed 's/ — Cognitive Protocol.*//')"

# --- Colors ---
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[0;33m'; BLUE='\033[0;34m'; NC='\033[0m'

log()     { echo -e "${BLUE}[INFO]${NC} $*"; }
success() { echo -e "${GREEN}[OK]${NC} $*"; }
warn()    { echo -e "${YELLOW}[WARN]${NC} $*"; }
error()   { echo -e "${RED}[ERROR]${NC} $*" >&2; }

# ============================================================================
# Utility Functions
# ============================================================================

inject_inline() {
    local config_file="$1" source_file="$2" base_name="$3"
    mkdir -p "$(dirname "$config_file")"
    touch "$config_file"
    {
        echo ""
        echo "<!-- COGNITIVE-BASE:$base_name:BEGIN -->"
        cat "$source_file"
        echo "<!-- COGNITIVE-BASE:$base_name:END -->"
    } >> "$config_file"
}

remove_inline() {
    local config_file="$1" base_name="$2"
    if [[ ! -f "$config_file" ]]; then return; fi
    local tmp="${config_file}.tmp.$$"
    sed "/<!-- COGNITIVE-BASE:$base_name:BEGIN -->/,/<!-- COGNITIVE-BASE:$base_name:END -->/d" \
        "$config_file" > "$tmp"
    mv "$tmp" "$config_file"
}

has_inline() {
    local config_file="$1" base_name="$2"
    [[ -f "$config_file" ]] && grep -qF "COGNITIVE-BASE:$base_name:BEGIN" "$config_file" 2>/dev/null
}

has_ref() {
    local config_file="$1" ref_pattern="$2"
    [[ -f "$config_file" ]] && grep -qF "$ref_pattern" "$config_file" 2>/dev/null
}

copy_skills() {
    local skill_dir="$1"
    mkdir -p "$skill_dir"
    for f in SKILL.md anti-patterns.md examples.md extended-protocol.md; do
        [[ -f "$SCRIPT_DIR/$f" ]] && cp "$SCRIPT_DIR/$f" "$skill_dir/"
    done
}

remove_skills() {
    local skill_dir="$1"
    [[ -d "$skill_dir" ]] && rm -rf "$skill_dir"
}

wrap_mdc() {
    local src="$1" dest="$2" title="$3"
    mkdir -p "$(dirname "$dest")"
    {
        echo "---"
        echo "description: \"$title cognitive protocol (cognitive base)\""
        echo "alwaysApply: true"
        echo "---"
        echo ""
        cat "$src"
    } > "$dest"
}

# ============================================================================
# Agent Detection
# ============================================================================

detect_claude_code() {
    command -v claude &>/dev/null || [[ -d "$HOME/.claude" ]]
}

detect_gemini_cli() {
    command -v gemini &>/dev/null || [[ -d "$HOME/.gemini" ]]
}

detect_codex_cli() {
    command -v codex &>/dev/null || [[ -d "$HOME/.codex" ]]
}

detect_cursor() {
    [[ -d "$HOME/.cursor" ]] || [[ -d "$PWD/.cursor" ]]
}

detect_opencode() {
    command -v opencode &>/dev/null || [[ -d "$HOME/.config/opencode" ]]
}

detect_openclaw() {
    [[ -d "$HOME/.openclaw" ]]
}

detect_all() {
    local agents=()
    detect_claude_code && agents+=("claude-code")
    detect_gemini_cli  && agents+=("gemini-cli")
    detect_codex_cli   && agents+=("codex-cli")
    detect_cursor      && agents+=("cursor")
    detect_opencode    && agents+=("opencode")
    detect_openclaw    && agents+=("openclaw")
    echo "${agents[@]}"
}

# ============================================================================
# Install Functions
# ============================================================================

install_claude_code() {
    local config_dir="$HOME/.claude"
    local config_file="$config_dir/CLAUDE.md"
    local protocol_dest="$config_dir/$BASE_NAME.md"
    local skill_dir="$config_dir/skills/$BASE_NAME"
    local ref_line="@~/.claude/$BASE_NAME.md"

    mkdir -p "$config_dir"
    touch "$config_file"

    if [[ "$MODE" == "inline" ]]; then
        # Remove ref mode if exists, then inject inline
        if has_ref "$config_file" "$ref_line"; then
            local tmp="${config_file}.tmp.$$"
            grep -vF "$ref_line" "$config_file" > "$tmp" || true
            mv "$tmp" "$config_file"
            rm -f "$protocol_dest"
            log "Claude Code: switched from @ ref to inline mode"
        fi
        if has_inline "$config_file" "$BASE_NAME"; then
            remove_inline "$config_file" "$BASE_NAME"
        fi
        inject_inline "$config_file" "$PROTOCOL_FILE" "$BASE_NAME"
    else
        # @ ref mode (default)
        if has_inline "$config_file" "$BASE_NAME"; then
            remove_inline "$config_file" "$BASE_NAME"
            log "Claude Code: switched from inline to @ ref mode"
        fi
        cp "$PROTOCOL_FILE" "$protocol_dest"
        if ! has_ref "$config_file" "$ref_line"; then
            echo "$ref_line" >> "$config_file"
        fi
    fi

    copy_skills "$skill_dir"
    success "Claude Code: $BASE_TITLE installed ($( [[ "$MODE" == "inline" ]] && echo "inline" || echo "@ ref" ) mode)"
}

install_gemini_cli() {
    local config_dir="$HOME/.gemini"
    local config_file="$config_dir/GEMINI.md"
    local protocol_dest="$config_dir/$BASE_NAME.md"
    local skill_dir="$config_dir/skills/$BASE_NAME"
    local ref_line="@~/.gemini/$BASE_NAME.md"

    mkdir -p "$config_dir"
    touch "$config_file"

    if [[ "$MODE" == "inline" ]]; then
        if has_ref "$config_file" "$ref_line"; then
            local tmp="${config_file}.tmp.$$"
            grep -vF "$ref_line" "$config_file" > "$tmp" || true
            mv "$tmp" "$config_file"
            rm -f "$protocol_dest"
        fi
        if has_inline "$config_file" "$BASE_NAME"; then
            remove_inline "$config_file" "$BASE_NAME"
        fi
        inject_inline "$config_file" "$PROTOCOL_FILE" "$BASE_NAME"
    else
        if has_inline "$config_file" "$BASE_NAME"; then
            remove_inline "$config_file" "$BASE_NAME"
        fi
        cp "$PROTOCOL_FILE" "$protocol_dest"
        if ! has_ref "$config_file" "$ref_line"; then
            echo "$ref_line" >> "$config_file"
        fi
    fi

    copy_skills "$skill_dir"
    success "Gemini CLI: $BASE_TITLE installed ($( [[ "$MODE" == "inline" ]] && echo "inline" || echo "@ ref" ) mode)"
}

install_codex_cli() {
    local config_dir="$HOME/.codex"
    local config_file="$config_dir/AGENTS.md"

    mkdir -p "$config_dir"
    touch "$config_file"

    if has_inline "$config_file" "$BASE_NAME"; then
        remove_inline "$config_file" "$BASE_NAME"
    fi
    inject_inline "$config_file" "$PROTOCOL_FILE" "$BASE_NAME"

    success "Codex CLI: $BASE_TITLE installed (inline mode)"
}

install_cursor() {
    local rules_dir
    if [[ -d "$PWD/.cursor" ]]; then
        rules_dir="$PWD/.cursor/rules"
    else
        rules_dir="$HOME/.cursor/rules"
    fi

    local mdc_file="$rules_dir/cognitive-base-$BASE_NAME.mdc"
    wrap_mdc "$PROTOCOL_FILE" "$mdc_file" "$BASE_TITLE"

    success "Cursor: $BASE_TITLE installed to $rules_dir/"
}

install_opencode() {
    local config_dir="$HOME/.config/opencode"
    local config_file="$config_dir/AGENTS.md"

    mkdir -p "$config_dir"
    touch "$config_file"

    if has_inline "$config_file" "$BASE_NAME"; then
        remove_inline "$config_file" "$BASE_NAME"
    fi
    inject_inline "$config_file" "$PROTOCOL_FILE" "$BASE_NAME"

    success "OpenCode: $BASE_TITLE installed (inline mode)"
}

install_openclaw() {
    local config_dir="$HOME/.openclaw/workspace"
    local config_file="$config_dir/AGENTS.md"

    mkdir -p "$config_dir"
    touch "$config_file"

    if has_inline "$config_file" "$BASE_NAME"; then
        remove_inline "$config_file" "$BASE_NAME"
    fi
    inject_inline "$config_file" "$PROTOCOL_FILE" "$BASE_NAME"

    success "OpenClaw: $BASE_TITLE installed (inline mode)"
}

# ============================================================================
# Uninstall Functions
# ============================================================================

uninstall_claude_code() {
    local config_dir="$HOME/.claude"
    local config_file="$config_dir/CLAUDE.md"
    local protocol_dest="$config_dir/$BASE_NAME.md"
    local skill_dir="$config_dir/skills/$BASE_NAME"
    local ref_line="@~/.claude/$BASE_NAME.md"
    local removed=false

    if has_ref "$config_file" "$ref_line"; then
        local tmp="${config_file}.tmp.$$"
        grep -vF "$ref_line" "$config_file" > "$tmp" || true
        mv "$tmp" "$config_file"
        rm -f "$protocol_dest"
        removed=true
    fi
    if has_inline "$config_file" "$BASE_NAME"; then
        remove_inline "$config_file" "$BASE_NAME"
        removed=true
    fi
    remove_skills "$skill_dir"

    if $removed; then
        success "Claude Code: $BASE_TITLE uninstalled"
    else
        warn "Claude Code: $BASE_TITLE was not installed"
    fi
}

uninstall_gemini_cli() {
    local config_dir="$HOME/.gemini"
    local config_file="$config_dir/GEMINI.md"
    local protocol_dest="$config_dir/$BASE_NAME.md"
    local skill_dir="$config_dir/skills/$BASE_NAME"
    local ref_line="@~/.gemini/$BASE_NAME.md"
    local removed=false

    if has_ref "$config_file" "$ref_line"; then
        local tmp="${config_file}.tmp.$$"
        grep -vF "$ref_line" "$config_file" > "$tmp" || true
        mv "$tmp" "$config_file"
        rm -f "$protocol_dest"
        removed=true
    fi
    if has_inline "$config_file" "$BASE_NAME"; then
        remove_inline "$config_file" "$BASE_NAME"
        removed=true
    fi
    remove_skills "$skill_dir"

    if $removed; then
        success "Gemini CLI: $BASE_TITLE uninstalled"
    else
        warn "Gemini CLI: $BASE_TITLE was not installed"
    fi
}

uninstall_codex_cli() {
    local config_file="$HOME/.codex/AGENTS.md"
    if has_inline "$config_file" "$BASE_NAME"; then
        remove_inline "$config_file" "$BASE_NAME"
        success "Codex CLI: $BASE_TITLE uninstalled"
    else
        warn "Codex CLI: $BASE_TITLE was not installed"
    fi
}

uninstall_cursor() {
    local removed=false
    for rules_dir in "$PWD/.cursor/rules" "$HOME/.cursor/rules"; do
        local mdc_file="$rules_dir/cognitive-base-$BASE_NAME.mdc"
        if [[ -f "$mdc_file" ]]; then
            rm -f "$mdc_file"
            removed=true
            success "Cursor: $BASE_TITLE uninstalled from $rules_dir/"
        fi
    done
    if ! $removed; then
        warn "Cursor: $BASE_TITLE was not installed"
    fi
}

uninstall_opencode() {
    local config_file="$HOME/.config/opencode/AGENTS.md"
    if has_inline "$config_file" "$BASE_NAME"; then
        remove_inline "$config_file" "$BASE_NAME"
        success "OpenCode: $BASE_TITLE uninstalled"
    else
        warn "OpenCode: $BASE_TITLE was not installed"
    fi
}

uninstall_openclaw() {
    local config_file="$HOME/.openclaw/workspace/AGENTS.md"
    if has_inline "$config_file" "$BASE_NAME"; then
        remove_inline "$config_file" "$BASE_NAME"
        success "OpenClaw: $BASE_TITLE uninstalled"
    else
        warn "OpenClaw: $BASE_TITLE was not installed"
    fi
}

# ============================================================================
# Status Function
# ============================================================================

show_status() {
    echo ""
    echo "=== $BASE_TITLE — Installation Status ==="
    echo ""

    # Claude Code
    local cc_file="$HOME/.claude/CLAUDE.md"
    if has_ref "$cc_file" "@~/.claude/$BASE_NAME.md"; then
        success "Claude Code: installed (@ ref mode)"
    elif has_inline "$cc_file" "$BASE_NAME"; then
        success "Claude Code: installed (inline mode)"
    else
        log "Claude Code: not installed"
    fi

    # Gemini CLI
    local gc_file="$HOME/.gemini/GEMINI.md"
    if has_ref "$gc_file" "@~/.gemini/$BASE_NAME.md"; then
        success "Gemini CLI: installed (@ ref mode)"
    elif has_inline "$gc_file" "$BASE_NAME"; then
        success "Gemini CLI: installed (inline mode)"
    else
        log "Gemini CLI: not installed"
    fi

    # Codex CLI
    local cx_file="$HOME/.codex/AGENTS.md"
    if has_inline "$cx_file" "$BASE_NAME"; then
        success "Codex CLI: installed (inline mode)"
    else
        log "Codex CLI: not installed"
    fi

    # Cursor
    local cursor_found=false
    for rules_dir in "$PWD/.cursor/rules" "$HOME/.cursor/rules"; do
        if [[ -f "$rules_dir/cognitive-base-$BASE_NAME.mdc" ]]; then
            success "Cursor: installed ($rules_dir/)"
            cursor_found=true
        fi
    done
    if ! $cursor_found; then
        log "Cursor: not installed"
    fi

    # OpenCode
    local oc_file="$HOME/.config/opencode/AGENTS.md"
    if has_inline "$oc_file" "$BASE_NAME"; then
        success "OpenCode: installed (inline mode)"
    else
        log "OpenCode: not installed"
    fi

    # OpenClaw
    local ocl_file="$HOME/.openclaw/workspace/AGENTS.md"
    if has_inline "$ocl_file" "$BASE_NAME"; then
        success "OpenClaw: installed (inline mode)"
    else
        log "OpenClaw: not installed"
    fi

    echo ""
}

# ============================================================================
# Usage
# ============================================================================

usage() {
    cat <<EOF
Usage: ./install.sh [OPTIONS]

Install $BASE_TITLE cognitive base to AI coding agents.

Options:
  --all             Install to all detected agents (no interactive menu)
  --inline          Force inline mode (no @ references)
  --agent=NAME      Install to specific agent only
                    (claude-code, gemini-cli, codex-cli, cursor, opencode, openclaw)
  --uninstall       Remove from all detected agents
  --status          Show installation status
  --quiet           Suppress non-essential output
  --help            Show this help

Examples:
  ./install.sh                          # Interactive: detect agents, choose which to install
  ./install.sh --all                    # Install to all detected agents
  ./install.sh --agent=claude-code      # Install to Claude Code only
  ./install.sh --inline --all           # Force inline mode for all agents
  ./install.sh --uninstall              # Uninstall from all agents
  ./install.sh --status                 # Check where it's installed
EOF
}

# ============================================================================
# Main
# ============================================================================

main() {
    # --- Pre-checks ---
    if [[ ! -f "$PROTOCOL_FILE" ]]; then
        error "cognitive-protocol.md not found in $SCRIPT_DIR"
        error "Run this script from the cognitive base repo root."
        exit 1
    fi

    # --- Parse arguments ---
    local ACTION="install"
    MODE="ref"  # default: @ ref for Claude Code / Gemini CLI
    local TARGET_AGENTS=()
    local ALL=false
    local QUIET=false

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --all)       ALL=true ;;
            --inline)    MODE="inline" ;;
            --agent=*)   TARGET_AGENTS+=("${1#--agent=}") ;;
            --uninstall) ACTION="uninstall" ;;
            --status)    ACTION="status" ;;
            --quiet)     QUIET=true ;;
            --help|-h)   usage; exit 0 ;;
            *)           error "Unknown option: $1"; usage; exit 1 ;;
        esac
        shift
    done

    # --- Status ---
    if [[ "$ACTION" == "status" ]]; then
        show_status
        exit 0
    fi

    # --- Detect agents ---
    if [[ ${#TARGET_AGENTS[@]} -eq 0 ]]; then
        IFS=' ' read -ra TARGET_AGENTS <<< "$(detect_all)"
    fi

    if [[ ${#TARGET_AGENTS[@]} -eq 0 ]]; then
        warn "No AI coding agents detected on this machine."
        echo "Supported agents: Claude Code, Gemini CLI, Codex CLI, Cursor, OpenCode, OpenClaw"
        exit 1
    fi

    # --- Interactive menu (unless --all or specific agent) ---
    if [[ "$ALL" == false ]] && [[ -t 1 ]] && [[ ${#TARGET_AGENTS[@]} -gt 1 ]]; then
        echo ""
        echo "=== $BASE_TITLE — Cognitive Base Installer ==="
        echo ""
        echo "Detected agents:"
        for i in "${!TARGET_AGENTS[@]}"; do
            echo "  $((i+1)). ${TARGET_AGENTS[$i]}"
        done
        echo ""
        read -rp "Install to all? [Y/n/numbers to select] " choice
        if [[ "$choice" =~ ^[Nn] ]]; then
            echo "Aborted."
            exit 0
        fi
        # If specific numbers given, filter (TODO: parse selection)
        # For now, proceed with all detected
    fi

    # --- Execute ---
    echo ""
    log "Installing $BASE_TITLE..."
    echo ""

    for agent in "${TARGET_AGENTS[@]}"; do
        local func_name="${agent//-/_}"
        if [[ "$ACTION" == "uninstall" ]]; then
            func_name="uninstall_$func_name"
        else
            func_name="install_$func_name"
        fi

        if declare -f "$func_name" &>/dev/null; then
            "$func_name"
        else
            warn "Unknown agent: $agent (skipping)"
        fi
    done

    echo ""
    if [[ "$ACTION" == "install" ]]; then
        log "Done. Start a new conversation to verify the cognitive base is active."
    else
        log "Done. $BASE_TITLE has been removed."
    fi
}

main "$@"
