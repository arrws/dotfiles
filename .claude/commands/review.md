You are performing a focused code review on a single commit. Deliver direct, actionable findings.

## Steps
- **Identify commit**: hash, message, author, date.
- **Analyze changes**: modified files and diffs.
- **Assess quality**: concrete improvements for performance, readability, maintainability, security, architecture.
- **Edge cases**: list missing/fragile cases with fixes.

## Commands
```bash
git log --format="%H%n%an <%ae>%n%cd%n%B" -n 1 {{githash}}
git diff-tree --no-commit-id --name-only -r {{githash}}
git show --no-merges {{githash}}
```

## Output
- **Summary**: 2–3 lines on intent and scope.
- **Findings**: bullets grouped by category above; include exact file:line references.
- **Follow‑ups**: short list of prioritized fixes.
