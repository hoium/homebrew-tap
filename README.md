# homebrew-tap

A personal [Homebrew](https://brew.sh) tap.

## jc-cli

An unofficial formula for the [JumpCloud CLI](https://github.com/TheJumpCloud/jc-cli) (`jc`).

```sh
brew tap hoium/tap
brew install jc-cli
```

Then `jc` is on your `PATH`:

```sh
jc --version
```

Shell completions for `bash`, `zsh`, and `fish` are installed automatically.

### Staying up to date

The formula tracks upstream `jc-cli` releases on its own. A scheduled GitHub
Action runs [`scripts/update-formula.sh`](scripts/update-formula.sh), which bumps
the pinned version and the per-platform checksums whenever JumpCloud publishes a
new release, then commits the change directly. To pick up a bump:

```sh
brew update && brew upgrade jc-cli
```

To bump the formula by hand:

```sh
scripts/update-formula.sh           # to the latest upstream release
scripts/update-formula.sh 1.27.0    # to a specific version
```

---

This tap is not affiliated with or endorsed by JumpCloud. `jc-cli` is published by
JumpCloud, Inc. under the MIT License.
