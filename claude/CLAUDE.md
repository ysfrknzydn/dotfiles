# Global Claude Code instructions

Personal preferences that apply across all projects. Add to this as you
notice yourself repeating the same instructions to Claude in different
projects — if you've said it twice, it probably belongs here instead.

## Environment facts

- macOS ships bash 3.2 — no associative arrays (`declare -A`) in shell scripts; use plain sequential logic instead.
- Forked subagents' (`Agent` tool, `subagent_type: "fork"`) WebSearch/WebFetch calls get rejected in this environment, likely because there's no live session to approve tool permissions for a background subagent. Forks work fine for local file reads (digesting a batch of files in parallel), but do direct web research from the main conversation, not via forks.

## Working preferences

- Verify numbers/citations/facts personally against the primary source before committing them to something that will be presented to someone else (a professor, a stakeholder, a report). A plausible-sounding fork/agent summary is not sufficient grounding on its own — go check the actual source text. This surfaced repeatedly on the Paceometer lit-review project, including a case where a published equation, taken at face value, produced physically impossible values (a units-mismatch in the source paper, not a transcription error).
- For rendered/visual output (diagrams, UI, charts) where the source markup can look correct but render wrong, verify with a real screenshot rather than trusting the source by eye. Mermaid diagrams in particular rendered garbled in ways only a real screenshot caught, even when the source looked plausible.
