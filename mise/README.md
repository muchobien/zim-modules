# mise

[zim module](https://github.com/zimfw/zimfw) for [mise](https://mise.jdx.dev)

## Features

- Activates `mise` for interactive shells (`mise activate zsh`)
- Regenerates and caches completions when the `mise` binary changes

## Install

Add to your `.zimrc`:

```zsh
zmodule muchobien/zim-modules --root mise
```

## Options

By default the module uses `mise activate zsh`, which refreshes the environment
on every prompt — the recommended mode for interactive shells.

To use [shims](https://mise.jdx.dev/dev-tools/shims.html) instead, set before the
module is initialized (e.g. in `.zshrc`):

```zsh
zstyle ':zim:mise' use-shims yes
```

> Toggling this option regenerates the cached init file only when the `mise`
> binary is newer. After changing it, refresh the cache with `zimfw build` or
> remove the module's `mise-init.zsh*`.

## Non-interactive shells (scripts, IDE terminals, git hooks)

**This module cannot help here** — zim is only sourced from `.zshrc`, which
non-interactive shells never read. Per mise's
[shims guide](https://mise.jdx.dev/dev-tools/shims.html), add the shims directory
to `PATH` in **`~/.zshenv`** (sourced by every shell):

```zsh
# ~/.zshenv — make mise-managed tools available to non-interactive shells
export PATH="$HOME/.local/share/mise/shims:$PATH"
```

Interactive activation (this module's `mise activate zsh`) automatically strips
the shims directory back out of `PATH`, so the two work together cleanly:
non-interactive shells get shims, interactive shells get full activation.
