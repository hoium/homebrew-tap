# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A personal [Homebrew](https://brew.sh) tap (`hoium/tap`) that currently ships one formula:
**`jc-cli`**, an unofficial formula for the [JumpCloud CLI](https://github.com/TheJumpCloud/jc-cli) (`jc`).

| Path | Purpose |
| ---- | ------- |
| [`Formula/jc-cli.rb`](Formula/jc-cli.rb) | The formula — pinned `version` plus four per-platform (macOS/Linux × arm64/amd64) `sha256` checksums. |
| [`scripts/update-formula.sh`](scripts/update-formula.sh) | Bumps the formula to a jc-cli release (`scripts/update-formula.sh [VERSION]`, defaults to latest). Rewrites the version and all four checksums from the release's `checksums.txt`; aborts without touching the formula if any expected asset is missing. Requires `gh`. |
| [`.github/workflows/update-formula.yml`](.github/workflows/update-formula.yml) | Scheduled Action that runs the script and commits bumps to `main`. See [`WORKFLOWS.md`](WORKFLOWS.md). |

### Working on the formula

- Never hand-edit the version or checksums — run `scripts/update-formula.sh` so all five values stay in sync with the upstream release.
- The formula installs a prebuilt binary (`bin.install "jc"`) and generates shell completions; there is no build step.
- Keep [`WORKFLOWS.md`](WORKFLOWS.md) current: add a row whenever a workflow is added or changed under `.github/workflows/`.

The sections below mirror the global `~/.claude/CLAUDE.md` so this repo follows the same process even when the global file isn't loaded. If they ever drift, the global file wins.

## Change Workflow (Ticket → Commit → Ship → Close)

Every substantive change to this repo (formula, scripts, workflows, docs) follows this sequence — do all of it without being asked, in this order:

1. **Create a ticket first** — before committing, create a tracking ticket describing the change. The ticket is a **Serval** ticket unless I explicitly say otherwise. Never commit before the ticket exists.
2. **Commit everything** — stage all files touched by the change and commit with the ticket's ID leading the subject (e.g., `IT-3460 feat(formula): ...`) so the commit links back to the ticket.
3. **Ship it — push or open a PR based on the size of the change:**
   - **Small, self-contained, complete changes** (single-script tweaks, doc updates, config fixes): push the commit directly to the default branch (`main`) immediately after committing.
   - **New larger projects or anything still in progress (TODO/WIP):** create a feature branch and open a pull request instead of pushing to `main`. Do not push incomplete or multi-part work directly to `main`.
4. **Close the ticket** — for small changes pushed to `main`, once the work is complete and pushed, mark the ticket **Done** to close it out. (For PR-based work, close the ticket when the PR is merged.)

### Serval Ticket Defaults

When I (Claude) create a Serval ticket, always:

- **Assign it to Jonathan Hoium** — set `assigned_to_user_id` to `151a4c82-b3ed-4058-a3de-75d2d7106ecf` (not just `requester_user_id`/`created_by_user_id`). The assignee param is `assigned_to_user_id`; `assigned_to_id` is silently ignored.
- **Apply the `Claude` and `AI` labels** so AI-created tickets are identifiable:
  - Claude: `01993019-ff70-7486-a15b-2e866220130a`
  - AI: `0198a8fa-c992-7651-8201-b0b502600b61`
  - `create_ticket` **ignores `label_ids`** — apply labels with a follow-up `update_ticket` call after the ticket exists. Add any other relevant topic labels alongside these (look them up with `list_labels`).
- **Descriptions:** use actual newline characters — never literal `\n`, which render as visible text in Serval.

Note: `update_ticket`'s `label_ids` **replaces** the whole set — when adding labels to an existing ticket, include its current labels too or they'll be dropped. (These IDs are for the Pacaso IT team `0197226f-05ce-7424-8e00-0e10fdd6bae8`.)

## Commit & Pull Request Guidelines

### Commit Message Format

Use conventional commit format with the tracking ticket ID leading the subject:

```text
[TICKET-ID] type(scope): description
```

- **Subject:** ticket ID, then `type(scope): description`. Lowercase description, imperative mood, no trailing period.
- **Blank line** between subject and body.
- **Body:** a bulleted list (each line starting with `-`) of the specific changes. Each bullet is a complete sentence ending with a period, in past tense (`Added`, `Updated`, `Removed`, `Fixed`).

**Examples:**

- `IT-4226 feat(formula): add jc-cli formula with per-platform checksums`
- `IT-3463 fix(scripts): abort update when a release asset checksum is missing`
- `IT-3460 docs: update CLAUDE.md commit guidelines`

### Commit Types

- **feat**: New feature, automation, script, or workflow
- **fix**: Bug fix or correction
- **refactor**: Restructuring without changing behavior
- **chore**: Maintenance tasks (dependencies, gitignore, tooling)
- **docs**: Documentation-only changes

### Scopes

Common scopes in this repo:

- **formula** — `Formula/*.rb`
- **scripts** — `scripts/`
- **ci** — `.github/workflows/`
- omit the scope for repo-wide or docs-only changes

### PR Title Format

```text
[TICKET-ID] type(scope): brief description
```

### PR Description Template

```markdown
## Summary
Brief description of what this PR accomplishes.

## Changes
- List of specific changes made

## Testing
- How the changes were tested
- Any manual verification steps

## Related Issues
- TICKET-ID (if applicable)
```
