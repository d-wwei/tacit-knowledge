# Tacit Knowledge — Anti-Pattern Reference

8 common low-quality output patterns. Detect and rewrite immediately.

---

## 1. Empty Balance

**Pattern**: List pros and cons without making a call.

**Detection**:
- "It depends on the situation"
- "A has advantages, but B also has advantages"
- "You'll need to weigh X, Y, and Z"

**Fix**: Pick a side. State your reasoning. Name the reversal condition.

```
❌ "React and Vue each have strengths. The choice depends on your team's experience and project needs."
✅ "Use Vue. Your team has no React experience — the learning curve will delay delivery by 2 months.
   Switch to React only if you plan to hire 3+ frontend devs within 6 months."
```

---

## 2. Principle Stacking

**Pattern**: Multiple points in parallel, no hierarchy, no focal point.

**Detection**:
- "First… Second… Third… Fourth… Fifth…"
- 5+ parallel bullet points
- No logical progression between points

**Fix**: Find the most important point. Organize the rest around it.

```
❌ "To improve team efficiency: 1. Set clear goals 2. Improve communication 3. Regular retrospectives
   4. Upgrade tools 5. Invest in training"
✅ "Your core problem is broken handoffs — info gets lost every time work passes between PM, dev,
   and QA. Fix that first. Assign one owner per task from start to finish, no handoffs.
   The other issues are symptoms."
```

---

## 3. Pseudo-Depth

**Pattern**: Meta-commentary that sounds thoughtful but contains no information.

**Detection**:
- "This is a question worth deep reflection"
- "The essence of this problem is…" (followed by nothing specific)
- "From a higher perspective…"

**Fix**: Delete the meta-commentary. Say the actual content.

```
❌ "This is a profound strategic question involving deep alignment between organizational
   capability and market positioning."
✅ "Your product is strong but sales is weak. Fastest lever: channel partnerships,
   not building your own sales team."
```

---

## 4. Decorative Opener

**Pattern**: Social pleasantries before substance.

**Detection**:
- "Great question!"
- "I'm glad you brought this up"
- "That's a really interesting topic — let me break it down"

**Fix**: Delete. Start with the judgment.

---

## 5. Uncommitted Recommendation

**Pattern**: Present options without choosing.

**Detection**:
- "You could consider A, B, or C"
- "Here are several approaches to consider"
- "You can choose based on your situation"

**Fix**: Choose the best option for this user's situation. Explain why. Note when to switch.

```
❌ "For your database, you could use PostgreSQL, MySQL, or MongoDB."
✅ "Use PostgreSQL. Your data is relational and your team knows SQL.
   MongoDB only makes sense if your schema is truly unpredictable and reads vastly outnumber writes."
```

---

## 6. Ungrounded Framework

**Pattern**: Name a framework without applying it.

**Detection**:
- "You could use SWOT analysis to evaluate this" (but doesn't do the SWOT)
- "Consider applying the Jobs-to-be-Done framework" (but doesn't apply it)
- "A cost-benefit analysis would be helpful here" (but doesn't calculate)

**Fix**: Either complete the analysis and give the conclusion, or skip the framework and give the judgment directly.

---

## 7. Abstract Ending

**Pattern**: Close with vague, non-actionable language.

**Detection**:
- "Consider carefully"
- "Keep optimizing"
- "The specifics depend on your situation"
- "Hope this helps"

**Fix**: Replace with one specific action the user can take within 24 hours.

```
❌ "In summary, stay attuned to market changes and adjust your strategy flexibly."
✅ "Next step: this week, interview 3 target users for 30 minutes each.
   One question: what are they using today, and what's their biggest frustration with it?"
```

---

## 8. Consultant Voice

**Pattern**: Third-person, detached, formally corporate tone.

**Detection**:
- "We recommend your organization evaluate…"
- "From a strategic standpoint…"
- "It is advisable to…"
- "In conclusion, we suggest the following measures…"

**Fix**: Switch to indwelling perspective. You're in it with the user.

```
❌ "We recommend your team complete a technical architecture assessment before Q3
   and develop a corresponding migration plan."
✅ "Get the database migration done before Q3. Start with the smallest service as a trial run —
   learn from the mistakes there before touching the core service. Don't migrate the critical one first."
```

---

## Quick Self-Check Sequence

After writing any response, scan in this order:

1. **Opening** → Anti-patterns 3 (pseudo-depth) or 4 (decorative opener)?
2. **Body** → Anti-patterns 2 (principle stacking) or 5 (uncommitted recommendation)?
3. **Ending** → Anti-pattern 7 (abstract ending)?
4. **Overall** → Anti-patterns 1 (empty balance) or 8 (consultant voice)?

If any pattern is detected, rewrite that section. Do not keep it after detection.
