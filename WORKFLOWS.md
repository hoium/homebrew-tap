# GitHub Actions Workflows

Every scheduled/automated workflow in this repo, when it fires, how to run it by hand, and
where to read its logs. **Keep this table current — add a row whenever you add a workflow
under [`.github/workflows/`](.github/workflows/).**

Repo: **`hoium/homebrew-tap`** · all cron times are **UTC**.

## Workflows

Schedule shows the cron value and its clock time in **UTC → ET**. GitHub Actions cron is always UTC,
so the ET wall-clock time shifts an hour with daylight saving — the table lists **EDT (summer) / EST (winter)**.

| Workflow (`name`) | Description | Schedule (UTC → ET) | Manual inputs |
| ------- | -------- | -------- | -------- |
| [Update jc-cli formula](.github/workflows/update-formula.yml) | Bumps `Formula/jc-cli.rb` to the latest upstream jc-cli release and commits the change to `main`. | `17 */6 * * *` — 00:17, 06:17, 12:17, 18:17 UTC → 8:17 p.m., 2:17 a.m., 8:17 a.m., 2:17 p.m. EDT / 7:17 p.m., 1:17 a.m., 7:17 a.m., 1:17 p.m. EST | none |

### What they do

- **Update jc-cli formula**: runs [`scripts/update-formula.sh`](scripts/update-formula.sh), which asks the
  GitHub API for the latest [`TheJumpCloud/jc-cli`](https://github.com/TheJumpCloud/jc-cli) release, then
  rewrites the formula's `version` and all four per-platform `sha256` checksums from the release's
  `checksums.txt`. If any expected asset is missing (half-published or yanked release), the script aborts
  without touching the formula. When the formula changed, the workflow commits it directly to `main` as
  `github-actions[bot]` with the message `Update jc-cli to <version>`; when it's already current, the run
  is a no-op ("No formula change."). Uses the built-in `GITHUB_TOKEN` (`contents: write`) — no extra
  secrets to maintain.

## How to trigger manually

Every workflow above supports `workflow_dispatch` (a **Run workflow** button).

**GitHub UI:** Actions tab → pick the workflow in the left sidebar → **Run workflow** → choose the branch
(usually `main`) → **Run workflow**.

**`gh` CLI** (from a clone of the repo):

```bash
# List workflows and their state
gh workflow list

# Kick off a formula-bump check right now
gh workflow run update-formula.yml

# Target a non-default branch
gh workflow run update-formula.yml --ref my-branch
```

To bump to a **specific** version (or test the script), skip the workflow and run it locally instead:

```bash
scripts/update-formula.sh           # to the latest upstream release
scripts/update-formula.sh 1.27.0    # to a specific version
```

## How to view logs / outputs

**GitHub UI:** Actions tab → click the workflow → click a run → click a job → expand steps to read logs.
Failed steps are pre-expanded and highlighted red.

**`gh` CLI:**

```bash
# Recent runs of one workflow (grab the run ID)
gh run list --workflow=update-formula.yml

# Full logs for a run; --log-failed shows only failed steps
gh run view <run-id> --log
gh run view <run-id> --log-failed

# Watch an in-progress run live
gh run watch <run-id>
```

**Other signals**

- **Commits on `main`** — a successful bump shows up as a `github-actions[bot]` commit
  (`Update jc-cli to <version>`) touching only `Formula/jc-cli.rb`.
- **No artifacts or notifications** — this workflow uploads nothing and doesn't post anywhere;
  the commit history and the run logs are the whole record.

> ⚠️ GitHub auto-disables cron schedules in repos with **no activity for 60 days** — if bumps ever
> stop, check the Actions tab for a "scheduled workflow disabled" banner and re-enable it.

---

> Maintenance: this doc must gain a row (and any trigger/input notes) whenever a new workflow is added under
> `.github/workflows/`. It's the single index of what runs automatically in this repo.
