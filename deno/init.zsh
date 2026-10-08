(( ${+commands[deno]} || ${+commands[asdf]} && ${+functions[_direnv_hook]} )) && () {

  local command=${commands[deno]:-"$(${commands[asdf]} which deno 2> /dev/null)"}
  [[ -z $command ]] && return 1

   # generating init file
  local initfile=$1/deno-init.zsh
  if [[ ! -e $initfile || $initfile -ot $command ]]; then
    $command completions zsh >| $initfile
    zcompile -UR $initfile
  fi

  source $initfile
} ${0:h}