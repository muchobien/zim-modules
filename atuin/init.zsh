# Atuin's shell integration, from `atuin init zsh` cached in atuin-init.zsh, plus
# completion in functions/.
() {
  # The real binary, not a version manager's shim: a shim's mtime doesn't change when
  # atuin is upgraded.
  local command=${commands[atuin]}
  if [[ -z $command || $command == */shims/* ]]; then
    if (( ${+commands[mise]} )); then
      command=$(mise which atuin 2>/dev/null)
    elif (( ${+commands[asdf]} )); then
      command=$(asdf which atuin 2>/dev/null)
    fi
  fi
  [[ -x $command ]] || return 1

  local -a init_args
  zstyle -a ':zim:atuin' init-args init_args
  # First line of the init file, so changing init-args generates it again.
  local header="# atuin init zsh ${init_args}"

  # Generated again when atuin, this file or init-args change.
  local initfile=$1/atuin-init.zsh
  if [[ ! -e $initfile || $initfile -ot $command || $initfile -ot $1/init.zsh ]] \
      || [[ $(<$initfile) != ${header}$'\n'* ]]; then
    local script
    script=$($command init zsh $init_args) || return 1
    print -rl -- $header $script >| $initfile
    zcompile -UR $initfile
  fi

  local compfile=$1/functions/_atuin
  if [[ ! -e $compfile || $compfile -ot $command ]]; then
    $command gen-completions --shell zsh >| $compfile
  fi

  source $initfile
} ${0:h}
