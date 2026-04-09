# Installing Tacit Knowledge for Gemini (Google)

## Method 1: System instructions (Gemini API)

Add the contents of `cognitive-protocol.md` to your system instruction:

```python
import google.generativeai as genai

with open("cognitive-protocol.md") as f:
    cognitive_rules = f.read()

model = genai.GenerativeModel(
    model_name="gemini-2.5-pro",
    system_instruction=cognitive_rules + "\n\n" + your_existing_instructions
)
```

## Method 2: Google AI Studio

In Google AI Studio, paste the contents of `cognitive-protocol.md` into the "System instructions" field.

## Method 3: Gemini CLI / agentic frameworks

If using Gemini through a CLI tool or agent framework, add `cognitive-protocol.md` to whatever file the framework reads as system instructions on startup.

## What to include

**Minimum**: `cognitive-protocol.md` (30 lines) — all essential rules.

**Recommended**: Also add the anti-pattern checklist from `anti-patterns.md`.

**Full**: Include `SKILL.md` for the complete framework.

## Notes

- Gemini's system instructions are loaded once per conversation, making them ideal for always-on cognitive rules.
- The protocol is model-agnostic and works with Gemini 2.5 Pro, Flash, and future models.
- If system instruction space is limited, `cognitive-protocol.md` alone carries most of the value.
