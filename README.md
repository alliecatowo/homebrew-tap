# homebrew-tap

Homebrew tap for [alliecatowo](https://github.com/alliecatowo)'s projects.

```sh
brew install alliecatowo/tap/<name>             # formula (CLI)
brew install --cask alliecatowo/tap/<name>      # cask (macOS app)
```

Installing by full name taps the repo automatically. To tap explicitly:
`brew tap alliecatowo/tap`.

## What's here

| Name | Kind | Install | Project |
| --- | --- | --- | --- |
| glassy | formula (macOS + Linux) | `brew install alliecatowo/tap/glassy` | [alliecatowo/glassy](https://github.com/alliecatowo/glassy) |
| glassy | cask (macOS app + CLI) | `brew install --cask alliecatowo/tap/glassy` | [alliecatowo/glassy](https://github.com/alliecatowo/glassy) |

Planned, added by each project's release job on its first release with Homebrew
support: `alliecode`, `patchrun`, `puml`.

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
in the source repo). Pull requests here are checked by
`brew style` and `brew audit --strict` (see `.github/workflows/ci.yml`).

## License

[MIT](LICENSE)
