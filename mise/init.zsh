(( ${+commands[mise]} || ${+commands[asdf]} )) && () {

  local command=${commands[mise]:-"$(${commands[asdf]} which mise 2> /dev/null)"}
  [[ -z $command ]] && return 1

  # Activation mode. `mise activate zsh` updates the environment on every prompt
  # (best for interactive shells). Opt into shims with
  #   zstyle ':zim:mise' use-shims yes
  # Shims work in non-interactive shells too, but for those you must add the
  # shims dir to PATH in ~/.zshenv (zim is not sourced there) — see the README.
  local -a activate_args=(zsh)
  zstyle -t ':zim:mise' use-shims && activate_args+=(--shims)

  # generating init file
  local initfile=$1/mise-init.zsh
  if [[ ! -e $initfile || $initfile -ot $command ]]; then
    $command activate $activate_args >| $initfile
    zcompile -UR $initfile
  fi

  local compfile=$1/functions/_mise
  if [[ ! -e $compfile || $compfile -ot $command ]]; then
    $command completion zsh >| $compfile
    print -u2 -PR "* Detected a new version 'mise'. Regenerated completions."
  fi

  source $initfile
} ${0:h}
