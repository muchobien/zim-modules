# zim-modules

[zim modules](https://github.com/zimfw/zimfw) in one repo, one per directory:

| Module | For |
|---|---|
| [`aws-sso-cli`](aws-sso-cli) | [aws-sso](https://synfinatic.github.io/aws-sso-cli) |
| [`bun`](bun) | [bun](https://bun.sh) |
| [`deno`](deno) | [deno](https://deno.com) |
| [`fnm`](fnm) | [fnm](https://github.com/Schniz/fnm) |
| [`mise`](mise) | [mise](https://mise.jdx.dev) |
| [`pritunl-client`](pritunl-client) | [pritunl-client](https://client.pritunl.com) |
| [`zoxide`](zoxide) | [zoxide](https://github.com/ajeetdsouza/zoxide) |

## Install

Add a line to `~/.zimrc` for each module you want, picking it with `--root`, then
run `zimfw install`:

```zsh
zmodule muchobien/zim-modules --root mise
zmodule muchobien/zim-modules --root zoxide
```

zimfw clones the repo once however many modules come from it. Each module's
README has its own details.

These used to be separate `muchobien/zim-<module>` repos, now archived. Their
history is here.
