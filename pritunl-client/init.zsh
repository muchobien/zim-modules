# Completion for pritunl-client, generated from its own `completion zsh`. The Pritunl
# app keeps the binary inside its bundle, so that's where it's looked for when it
# isn't on PATH.
() {
  local command=${commands[pritunl-client]:-/Applications/Pritunl.app/Contents/Resources/pritunl-client}
  [[ -x $command ]] || return 1

  local compfile=$1/functions/_pritunl-client
  if [[ ! -e $compfile || $compfile -ot $command ]]; then
    $command completion zsh >| $compfile
    print -u2 -PR "* Detected a new version 'pritunl-client'. Regenerated completions."
  fi
} ${0:h}
