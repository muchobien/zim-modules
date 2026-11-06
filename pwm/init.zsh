() {
  local command=${commands[pwm]}
  if [[ -z $command || $command == */shims/* ]]; then
    if (( ${+commands[mise]} )); then
      command=$(mise which pwm 2>/dev/null)
    elif (( ${+commands[asdf]} )); then
      command=$(asdf which pwm 2>/dev/null)
    fi
  fi
  [[ -x $command ]] || return 1

  local compfile=$1/functions/_pwm
  if [[ ! -e $compfile || $compfile -ot $command ]]; then
    $command completion zsh >| $compfile
  fi
} ${0:h}
