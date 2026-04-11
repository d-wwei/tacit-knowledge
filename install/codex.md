# Installing Tacit Knowledge for Codex (OpenAI)

> **Recommended**: Run `./install.sh --agent=codex-cli` from the repo root for automated installation.
> The manual steps below are for reference or troubleshooting.

## Method 1: AGENTS.md (recommended for Codex CLI)

If you're using Codex CLI, add the contents of `cognitive-protocol.md` to your project's `AGENTS.md` file:

```bash
cat cognitive-protocol.md >> AGENTS.md
```

Or for global application, add to your user-level instructions file.

## Method 2: System prompt (for API-based Codex)

Prepend the contents of `cognitive-protocol.md` to your system prompt:

```python
with open("cognitive-protocol.md") as f:
    cognitive_rules = f.read()

system_prompt = cognitive_rules + "\n\n" + your_existing_prompt
```

## Method 3: Custom instructions

If using Codex through ChatGPT or the API with custom instructions, paste the contents of `cognitive-protocol.md` into the custom instructions field.

## What to include

**Minimum (core rules only)**: `cognitive-protocol.md` — 30 lines, covers all essential cognitive shifts.

**Full version**: Also include the anti-pattern checklist from `anti-patterns.md` — adds 8 specific patterns to detect and rewrite.

**Maximum**: Include `SKILL.md` for the complete framework with composition interface and intensity calibration.

## Notes

- Codex does not have a skill auto-discovery mechanism like Claude Code, so the rules must be explicitly included in the prompt or instructions.
- The cognitive protocol is model-agnostic — it works the same way with GPT-4, GPT-4o, or any future model.
- If your prompt is already long, start with just `cognitive-protocol.md` (30 lines). It carries ~80% of the value.
