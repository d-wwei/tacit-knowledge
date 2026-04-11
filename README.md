# Tacit Knowledge

A cognitive protocol for AI agents. Makes any LLM-based agent think more like an experienced practitioner — commit to judgments, surface hidden signals, and give actionable advice instead of safe platitudes.

Works with **any** AI agent framework: Claude Code, Codex, Gemini, OpenCode, Cline, Cursor, or raw system prompts.

## What it does

Default AI output has a fundamental flaw: it optimizes for "least likely to be criticized" instead of "most useful." This produces balanced-but-empty responses, lists without priorities, and advice that sounds smart but doesn't help.

Tacit Knowledge fixes this by injecting a cognitive protocol — a set of thinking rules that change **how** the agent reasons, not what domain it works in.

### Before (default agent)

> "Microservices and monoliths each have pros and cons. Microservices offer independent deployment, tech stack flexibility, and fault isolation. Monoliths offer simplicity, easier debugging, and simpler deployment. The choice depends on your team size, business complexity, and operational maturity."

### After (with Tacit Knowledge)

> "Stay on the monolith. With 8 people, the coordination cost of microservices will eat all the gains. If adding a feature touches 3+ modules, the problem isn't the monolith — it's that your module boundaries are wrong. Fix those first. Revisit microservices when you hit 20 engineers or one module needs 10x the traffic of the others."

## How it works

The protocol applies four cognitive shifts to every response:

| Default Mode | Tacit Knowledge Mode |
|---|---|
| Balance — list pros/cons, let user decide | **Commit** — give a judgment with conditions and reversal points |
| Flat — all points equally weighted | **Hierarchy** — one focal point, 2-3 supporting signals |
| External — generic advice from outside | **Indwelling** — think from inside the user's situation |
| Reductive — break into parts first | **Holistic** — diagnose the whole pattern before fixing parts |

Plus an information filter:

- **SKIP** — things the user already knows → don't repeat
- **SURFACE** — things experienced people know but rarely say → proactively share
- **PUSH** — integrative judgments that require weighing multiple signals → commit and explain

And an output quality gate that catches 8 anti-patterns (empty balance, principle stacking, pseudo-depth, decorative openers, uncommitted recommendations, ungrounded frameworks, abstract endings, consultant voice).

## Installation

### Claude Code

```bash
# 1. Copy the skill
mkdir -p ~/.claude/skills/tacit-knowledge
cp SKILL.md ~/.claude/skills/tacit-knowledge/
cp anti-patterns.md ~/.claude/skills/tacit-knowledge/
cp examples.md ~/.claude/skills/tacit-knowledge/

# 2. Inject core rules into CLAUDE.md (ensures always-on)
cp cognitive-protocol.md ~/.claude/tacit-knowledge.md
echo '@~/.claude/tacit-knowledge.md' >> ~/.claude/CLAUDE.md
```

See [install/claude-code.md](install/claude-code.md) for details.

### Codex (OpenAI)

Add the contents of `cognitive-protocol.md` to your Codex system instructions or `AGENTS.md` file.

See [install/codex.md](install/codex.md) for details.

### Gemini (Google)

Add the contents of `cognitive-protocol.md` to your Gemini system instructions or custom instructions field.

See [install/gemini.md](install/gemini.md) for details.

### Any other agent

Paste the contents of `cognitive-protocol.md` into whatever file your agent reads on startup (system prompt, instructions file, config). The rules are framework-agnostic — they work with any LLM.

See [install/generic.md](install/generic.md) for details.

## File structure

```
tacit-knowledge/
├── README.md                  ← You are here
├── cognitive-protocol.md      ← Core rules (~30 lines, always-on)
├── SKILL.md                   ← Full framework (~120 lines, reference)
├── anti-patterns.md           ← 8 anti-patterns with detection & fixes
├── examples.md                ← 3 before/after comparisons
├── install/                   ← Platform-specific install guides
│   ├── claude-code.md
│   ├── codex.md
│   ├── gemini.md
│   └── generic.md
└── docs/                      ← Background articles
    ├── why-tacit-knowledge.md
    └── what-is-cognitive-base.md
```

## Composability

Tacit Knowledge is a **cognitive base layer**, not a domain skill. It changes how the agent thinks, not what it does. This means it stacks with any domain-specific skill:

- **Tacit Knowledge + Design Skill** → design with aesthetic commitment, not template defaults
- **Tacit Knowledge + Coding Skill** → architecture decisions with clear direction, not pros/cons lists
- **Tacit Knowledge + Writing Skill** → articles with a point of view, not balanced summaries

It never conflicts with domain skills because they operate at different levels:
- Cognitive base = **how** to think (judgment, hierarchy, perspective, holism)
- Domain skill = **what** to do (specific rules, formats, techniques)

## Theoretical foundation

This project operationalizes ideas from Michael Polanyi's theory of tacit knowledge — the insight that "we can know more than we can tell." LLMs have vast implicit knowledge from training data, but their default output mode suppresses it in favor of safe, balanced, generic responses. The cognitive protocol unlocks this by giving the agent permission to commit, prioritize, and surface signals that experienced practitioners would notice.

For a deeper dive, see:
- [Why Tacit Knowledge Changes Agent Behavior](docs/why-tacit-knowledge.md)
- [What Is a Cognitive Base Skill](docs/what-is-cognitive-base.md)

## License

MIT

---

## All Cognitive Bases

Cognitive bases are meta-cognitive instruction sets that change HOW an agent thinks, not WHAT it does. Each one targets a different cognitive axis. Mix and match.

| Cognitive Base | What it changes |
|---|---|
| [First Principles](https://github.com/d-wwei/first-principles) | Reason from verified foundations, not inherited conventions |
| [Results-Driven](https://github.com/d-wwei/results-driven) | Require evidence for completion, not just activity |
| [Attention Allocation](https://github.com/d-wwei/attention-allocation) | Find and concentrate on the ONE binding constraint |
| [Bayesian Reasoning](https://github.com/d-wwei/bayesian-reasoning) | Calibrated probability thinking, not binary judgments |
| [Constraint as Catalyst](https://github.com/d-wwei/constraint-as-catalyst) | Turn constraints into innovation catalysts |
| [Conviction Override](https://github.com/d-wwei/conviction-override) | Override rational caution when obstacles are convention, not physics |
| [Cross-Domain Connector](https://github.com/d-wwei/cross-domain-connector) | Detect structural isomorphisms across disciplines |
| [Dialectical Thinking](https://github.com/d-wwei/dialectical-thinking) | Synthesize through contradictions (矛盾论) |
| [Double-Loop Learning](https://github.com/d-wwei/double-loop-learning) | Question the assumptions that produce errors |
| [Frame Auditing](https://github.com/d-wwei/frame-auditing) | Detect and transcend invisible analytical frames |
| [Interactive Cognition](https://github.com/d-wwei/interactive-cognition) | Model others' cognition and manage information flow |
| [Inversion Thinking](https://github.com/d-wwei/inversion-thinking) | Map failure modes first, then avoid them |
| [Motivation Audit](https://github.com/d-wwei/motivation-audit) | Audit motivational drivers before analysis (正心诚意) |
| [Non-Attachment](https://github.com/d-wwei/non-attachment) | Radical cognitive freedom — use frameworks without fusing |
| [Principled Action](https://github.com/d-wwei/principled-action) | Unify knowing and doing through practice-theory spirals (知行合一) |
| [Second-Order Thinking](https://github.com/d-wwei/second-order-thinking) | Trace consequences beyond first-order effects |
| [Systems Thinking](https://github.com/d-wwei/systems-thinking) | Feedback-driven structural analysis, not linear cause-effect |
| [Temporal Wisdom](https://github.com/d-wwei/temporal-wisdom) | Make time your ally — compound effects and phase awareness |
| [Cognitive Base Creator](https://github.com/d-wwei/cognitive-base-creator) | Generate new cognitive bases from any thinking framework |
