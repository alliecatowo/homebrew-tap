# homebrew-tap

Homebrew tap for [alliecatowo](https://github.com/alliecatowo)'s projects.

```sh
brew install alliecatowo/tap/<name>             # formula (CLI)
brew install --cask alliecatowo/tap/<name>      # cask (macOS app)
```

Or tap once, then use the short name:

```sh
brew tap alliecatowo/tap
brew install <name>
```

The full name `alliecatowo/tap/<name>` taps the repo automatically. The shorter
`brew install alliecatowo/<name>` does **not** work: Homebrew reads
`alliecatowo/<name>` as a tap called `alliecatowo/homebrew-<name>`, which does not exist.

## What's here

| Name | Kind | Install | Project |
| --- | --- | --- | --- |
| glassy | formula (macOS + Linux) | `brew install alliecatowo/tap/glassy` | [alliecatowo/glassy](https://github.com/alliecatowo/glassy) |
| glassy | cask (macOS app + CLI) | `brew install --cask alliecatowo/tap/glassy` | [alliecatowo/glassy](https://github.com/alliecatowo/glassy) |
| puml | formula (macOS + Linux) | `brew install alliecatowo/tap/puml` | [alliecatowo/puml](https://github.com/alliecatowo/puml) |
| ticket-master (`tm`) | formula (macOS + Linux) | `brew install alliecatowo/tap/ticket-master` | [alliecatowo/ticket-master](https://github.com/alliecatowo/ticket-master) |
| lumen | formula (macOS + Linux) | `brew install alliecatowo/tap/lumen` | [alliecatowo/lumen](https://github.com/alliecatowo/lumen) |
| git-why | formula (macOS + Linux, needs `node`) | `brew install alliecatowo/tap/git-why` | [alliecatowo/git-why](https://github.com/alliecatowo/git-why) |
| shoal | formula (macOS + Linux) | `brew install alliecatowo/tap/shoal` | [alliecatowo/shoal](https://github.com/alliecatowo/shoal) |

Planned, added by the project's release job on its first release with Homebrew
support: `alliecode`.

## Coming from `alliecatowo/glassy`?

glassy used to be its own tap. That tap is replaced by this one:

```sh
brew untap alliecatowo/glassy && brew tap alliecatowo/tap
brew reinstall alliecatowo/tap/glassy        # or: brew reinstall --cask alliecatowo/tap/glassy
```

## How formulae get here

Formulae and casks are not edited by hand. Each project's release workflow
renders its file with the new version and checksums and pushes it to `main`
here, authenticating with a write deploy key (secret `HOMEBREW_TAP_DEPLOY_KEY`
in the source repo). CI here runs `brew style` and `brew audit --strict`, then
installs every formula on Ubuntu and macOS and runs its binary (see
`.github/workflows/ci.yml`).

## License

[MIT](LICENSE)
