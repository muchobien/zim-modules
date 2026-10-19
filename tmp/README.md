# tmp

[zim module](https://github.com/zimfw/zimfw) for temporary workspaces.

## Install

Add this to `~/.zimrc`, before the `completion` module, then run `zimfw install`:

```zsh
zmodule muchobien/zim-modules --root tmp
```

Start a new shell to load the function and flag completion.

## Usage

```zsh
tmp         # Create a unique directory, enter it, and print its path.
tmp --last  # Enter the most recently created directory that still exists.
tmp --list  # Print existing directory paths, newest first.
tmp --delete # Delete the workspace you are in, after confirmation.
tmp --clean # Delete all listed directories and their contents after confirmation.
tmp --help  # Show usage.
```

Directories are kept under `${TMPDIR:-/tmp}/zsh-tmp-$UID/` by default, with
names such as `tmp-2026-10-19_143205.123456.aB3xQ9`. Timestamps use UTC.
The list is shared across shell sessions and ordered by the timestamp in each
name; editing files in an older directory does not make it the newest one.
Only immediate subdirectories named `tmp-*` are included. Keep their generated
names if you want creation ordering to remain accurate.

If there are no directories, `--list` and `--clean` report that and succeed;
`--last` reports that and returns a nonzero status. These commands do not create
a directory.

`--clean` asks for confirmation; enter `y` or `yes` to permanently delete the
directories shown by `--list`, including their contents. Any other response or
end of input cancels without deleting anything and returns a nonzero status.
If the current shell is inside one of those directories, it moves to the
configured parent directory before deleting. Other files and directories in
the parent are left alone.

`--delete` asks for confirmation to delete only the managed workspace containing
the current directory, including when you are in a nested subdirectory or
entered through a symlink. It moves the shell to the configured parent first.
Other workspaces are left alone. Outside a managed workspace it returns a
nonzero status without deleting anything. Cancellation works as with `--clean`.

The system may also clean temporary storage, including between reboots.

## Options

Choose a different parent directory with `zstyle`, set before the module is
initialized (e.g. in `~/.zshrc` before Zim's initialization):

```zsh
zstyle ':zim:tmp' directory "$HOME/tmp"
```

The directory is created on the first `tmp` call. A location outside system
temporary storage lets you keep workspaces until you delete them yourself.
