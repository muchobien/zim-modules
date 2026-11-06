# pwm

[zim module](https://github.com/zimfw/zimfw) for [pwm](https://git.krosf.com/krosf/pwm)

## Features

- Completion for `pwm`: commands, options and their values, and session names
  from `pwm list`

## Install

Add it to `~/.zimrc` after the module that puts `pwm` on your `PATH` (e.g.
`mise` from this repo), then run `zimfw install`:

```zsh
zmodule muchobien/zim-modules --root pwm
```

Installed through mise or asdf works too, even when only their shims are on
`PATH`: the module finds the real binary with `mise which` / `asdf which`.

The completion is generated from `pwm completion zsh` into `functions/_pwm`, again
whenever pwm is updated.
