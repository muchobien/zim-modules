# lyra

[zim module](https://github.com/zimfw/zimfw) for [lyra](https://github.com/muchobien/lyra)

## Features

- Completion for `lyra`: commands, options and their values

## Install

Add it to `~/.zimrc` after the module that puts `lyra` on your `PATH` (e.g.
`mise` from this repo), then run `zimfw install`:

```zsh
zmodule muchobien/zim-modules --root lyra
```

Installed through mise or asdf works too, even when only their shims are on
`PATH`: the module finds the real binary with `mise which` / `asdf which`.

The completion is generated from `lyra completion zsh` into `functions/_lyra`, again
whenever lyra is updated.
