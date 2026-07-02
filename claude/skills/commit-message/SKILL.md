---
name: commit-message
description: Write a commit message for the currently staged git changes. Use when the user asks to commit, write a commit message, or says "commit this" without dictating the message themselves.
---

# Commit Message: write one from the staged diff

Write a clear, conventional commit message from what's actually staged — never invent
changes that aren't in the diff.

## Steps

1. Run `git diff --staged` to see what will be committed. If nothing is staged, say so
   and ask whether to stage first (don't run `git add` yourself unless asked).
2. Read the diff for *why* the change was made, not just what lines moved — check
   surrounding code/comments for intent when it isn't obvious.
3. Write a message in this format:
   ```
   <type>: <short summary, imperative mood, no trailing period>

   <optional body — only if the why isn't obvious from the summary>
   ```
   Common `type` values: `feat`, `fix`, `refactor`, `docs`, `test`, `chore`.
4. Keep the summary line under ~72 characters.
5. Show the user the drafted message and ask before running `git commit` — don't commit
   silently.

## Notes

- Do not add AI attribution (e.g. "Co-Authored-By: Claude") unless the user's workflow
  already does that elsewhere.
- If the staged diff mixes unrelated changes (e.g. a bug fix + an unrelated formatting
  pass), point that out — it may be worth splitting into two commits.
