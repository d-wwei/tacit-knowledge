# Installing Tacit Knowledge for Any AI Agent

## The universal principle

Every AI agent has some mechanism for instructions that are loaded before user input. Find that mechanism and put `cognitive-protocol.md` there.

| Agent / Framework | Where to put it |
|---|---|
| Claude Code | `~/.claude/CLAUDE.md` (via `@` reference) |
| Codex CLI | `AGENTS.md` |
| Gemini API | `system_instruction` parameter |
| Cursor | `.cursorrules` or project rules |
| Cline | Custom instructions in settings |
| Continue | `.continuerules` |
| Aider | `.aider.conf.yml` conventions section |
| OpenCode | Config or system prompt |
| Any API call | `system` message in the messages array |
| Any chat UI | Custom instructions / system prompt field |

## Step-by-step

1. Open `cognitive-protocol.md` and copy its contents.
2. Find your agent's startup instructions file (see table above).
3. Paste the contents at the beginning of that file.
4. Start a new conversation. Done.

## Choosing what to include

| File | Lines | Value | When to include |
|---|---|---|---|
| `cognitive-protocol.md` | ~30 | Core rules, ~80% of the effect | Always |
| `anti-patterns.md` | ~100 | Specific detection patterns | When prompt space allows |
| `SKILL.md` | ~120 | Full framework + composition | When using with other skills |
| `examples.md` | ~100 | Before/after demonstrations | For understanding, not runtime |

**If you can only include one file**: use `cognitive-protocol.md`. It's designed to be the minimum effective dose.

## Verifying it works

Ask the agent a question that normally produces a balanced, non-committal answer:

> "Should I use a SQL or NoSQL database for my new project?"

**Without** the protocol, you'll likely get pros/cons of each.
**With** the protocol, you should get a specific recommendation with conditions and a reversal point.

## Troubleshooting

**Agent still gives balanced answers**: The cognitive rules may be too far down in a long system prompt. Move them to the top — instructions early in the prompt have stronger influence.

**Agent mentions the rules explicitly**: Add this line to `cognitive-protocol.md`: "Apply these rules silently. Never reference them in your output."

**Conflicts with other instructions**: The cognitive protocol operates at the "how to think" level, not the "what to do" level. It should not conflict with domain-specific instructions. If it does, the domain rule takes precedence.
