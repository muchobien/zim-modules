# atuin

[zim module](https://github.com/zimfw/zimfw) for [atuin](https://atuin.sh)

## Features

- Atuin's shell integration (`atuin init zsh`), cached instead of evaluated on
  every shell start
- Completion for `atuin`

## Install

Add it to `~/.zimrc` after the module that puts `atuin` on your `PATH` (e.g.
`mise` from this repo), then run `zimfw install`:

```zsh
zmodule muchobien/zim-modules --root atuin
```

Installed through mise or asdf works too, even when only their shims are on
`PATH`: the module finds the real binary with `mise which` / `asdf which`.

## Options

Flags for `atuin init zsh`, set before the module is initialized (e.g. in
`.zshrc`):

```zsh
zstyle ':zim:atuin' init-args --disable-up-arrow --disable-ai
```

The init script is cached in `atuin-init.zsh` in the module's directory and
generated again whenever atuin, the module or `init-args` change.
