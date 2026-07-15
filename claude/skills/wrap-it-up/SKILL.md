---
name: wrap-it-up
description: Close out a work session — refreshes CLAUDE.md via /init, updates the repo's README if the session's changes warrant it, drafts a next-session to-do list from what's left undone, then hands back terminal commands (with a recommended commit message) for the user to commit and push themselves. Use when the user says "wrap it up", "wrap this up", or wants to close out before committing.
---

# Wrap It Up: close out a session

Refresh docs, then hand the user copy-pasteable commands to finish the job. This skill
never runs `git commit` or `git push` itself — it only prepares things and prints
instructions for the user to run.

## Steps

1. **Confirm this is a git repo.** Run `git rev-parse --is-inside-work-tree`. If it
   fails, say so and stop (or offer to `git init` if the user wants that).

2. **Refresh CLAUDE.md.** Invoke the `init` skill (via the Skill tool) to
   (re)generate/update the project's `CLAUDE.md` with current codebase documentation.

3. **Update the README if applicable.** Check whether a `README.md` (or similar) exists
   at the repo root.
   - Look at what changed this session (`git status`, `git diff`) and judge whether any
     of it is README-relevant: new/changed usage, setup steps, CLI flags, public API,
     dependencies, etc.
   - If nothing user-facing changed, or there's no README, skip this step — don't force
     an edit for its own sake.
   - If an update is warranted, edit the README directly (this is a reversible local
     file edit, not a commit/push, so it's fine to do without asking first).

4. **Review the full diff.** Run `git status` and `git diff` (staged + unstaged) to see
   everything that will need to be committed, including the CLAUDE.md/README updates
   from steps 2–3.

5. **Draft a commit message** from the actual diff — same bar as the `commit-message`
   skill: imperative mood, focused on *why*, no invented changes.
   ```
   <type>: <short summary, imperative mood, no trailing period>

   <optional body — only if the why isn't obvious from the summary>
   ```

6. **Return terminal instructions** — do not execute `git add`/`commit`/`push` yourself.
   Print a copy-pasteable block, e.g.:
   ```bash
   git add -A
   git commit -m "<recommended message>"
   git push
   ```
   - If unrelated changes are mixed together, flag that and suggest splitting into
     separate `git add <path>` / commits instead of `-A`.
   - If the current branch has no upstream yet, use `git push -u origin <branch>`
     instead of a bare `git push`.
   - Do not add AI attribution (e.g. "Co-Authored-By: Claude") unless the user's
     existing commits already do that.

7. **Draft a to-do list for the next session.** Based on the session's actual
   conversation and diff — incomplete work, TODO/FIXME comments just added, a plan step
   that was never reached, failing/skipped tests, or something the user explicitly said
   they'd get to later — write a short, concrete checklist of what's left. Skip this
   entirely if the session's work is genuinely done and nothing is outstanding; don't
   invent items to pad it out.
   - If it's genuinely unclear what should come next (multiple plausible directions, the
     session ended mid-decision, or you're guessing at priority), ask the user directly
     with `AskUserQuestion` instead of guessing — their answer becomes the list.
   - Present the list as plain markdown checkboxes in the final response, right after the
     commit instructions, e.g.:
     ```markdown
     ## Next session
     - [ ] <concrete next item>
     - [ ] <concrete next item>
     ```
   - Don't write this to a file unless the user asks — it's a handoff note in the
     response, not a new doc in the repo.

## Notes

- This skill is read/prepare-only with respect to version control: it inspects and
  drafts, but leaves the actual commit/push action — which is visible to others and
  hard to reverse — in the user's hands.
- If `init` or the README update turns up nothing to change, say so plainly rather than
  padding the output.
- Same for the next-session list: if there's nothing left, say so instead of manufacturing
  filler to-dos.
