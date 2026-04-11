# Installing Tacit Knowledge for Claude Code

> **Recommended**: Run `./install.sh` from the repo root for automated installation with dual-mode support (@ reference + inline fallback).
> The manual steps below are for reference or troubleshooting.

## Quick install

```bash
# Clone the repo
git clone https://github.com/d-wwei/tacit-knowledge.git
cd tacit-knowledge

# Copy skill files
mkdir -p ~/.claude/skills/tacit-knowledge
cp SKILL.md anti-patterns.md examples.md ~/.claude/skills/tacit-knowledge/

# Inject core rules into CLAUDE.md (direct content injection — works on all versions)
cat cognitive-protocol.md >> ~/.claude/CLAUDE.md
```

## How it works in Claude Code

Claude Code reads `~/.claude/CLAUDE.md` at the start of **every** conversation. The core cognitive rules are directly injected into CLAUDE.md, so they load automatically — no manual trigger needed, no version-specific features required.

The full SKILL.md in `~/.claude/skills/tacit-knowledge/` serves as a detailed reference that Claude Code can access when deeper guidance is needed.

### Two layers

| Layer | File | Loaded when | Purpose |
|---|---|---|---|
| Core rules | `~/.claude/CLAUDE.md` (appended) | Every conversation (part of CLAUDE.md) | Always-on cognitive shifts |
| Full reference | `~/.claude/skills/tacit-knowledge/SKILL.md` | When agent detects relevance | Detailed anti-patterns, examples, composition guide |

## Adding a custom slash command alias

By default the skill is triggered with `/tacit-knowledge`. To add a shorter or localized alias (e.g. `/默会知识`), create a symlink:

```bash
ln -s ~/.claude/skills/tacit-knowledge ~/.claude/skills/默会知识
```

Now both `/tacit-knowledge` and `/默会知识` invoke the same skill.

## Verifying installation

Start a new Claude Code conversation and ask any question that requires judgment (e.g., "Should I use TypeScript or JavaScript for this project?"). The response should:

- Start with a clear judgment, not "it depends"
- Have a focal point with supporting signals, not a flat list
- End with a concrete next step, not "consider carefully"

## Uninstalling

```bash
# Remove the Tacit Knowledge section from ~/.claude/CLAUDE.md
# (search for the "# Tacit Knowledge — Cognitive Protocol" header and delete that section)

# Remove skill files
rm -rf ~/.claude/skills/tacit-knowledge
```
