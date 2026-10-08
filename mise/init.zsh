(( ${+commands[mise]} || ${+commands[asdf]} && ${+functions[_direnv_hook]} )) && () {

  local command=${commands[mise]:-"$(${commands[asdf]} which mise 2> /dev/null)"}
  [[ -z $command ]] && return 1

   # generating init file
  local initfile=$1/mise-init.zsh
  if [[ ! -e $initfile || $initfile -ot $command ]]; then
    $command activate zsh >| $initfile
    zcompile -UR $initfile
  fi

  local compfile=$1/functions/_mise
  if [[ ! -e $compfile || $compfile -ot $command ]]; then
    $command completion zsh >| $compfile
    print -u2 -PR "* Detected a new version 'mise'. Regenerated completions."
  fi

  source $initfile
} ${0:h}