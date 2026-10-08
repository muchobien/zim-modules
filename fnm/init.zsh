(( ${+commands[fnm]} || ${+commands[asdf]} && ${+functions[_direnv_hook]} )) && () {

  local command=${commands[fnm]:-"$(${commands[asdf]} which fnm 2> /dev/null)"}
  [[ -z $command ]] && return 1

   # generating init file
  local initfile=$1/fnm-init.zsh
  if [[ ! -e $initfile || $initfile -ot $command ]]; then
    $command env --shell zsh --corepack-enabled --use-on-cd >| $initfile
    zcompile -UR $initfile
  fi

  local compfile=$1/functions/_fnm
  if [[ ! -e $compfile || $compfile -ot $command ]]; then
    $command completions --shell zsh >| $compfile
    print -u2 -PR "* Detected a new version 'fnm'. Regenerated completions."
  fi

  source $initfile
} ${0:h}