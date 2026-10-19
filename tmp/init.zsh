# Temporary workspaces, with the directory list shared across shell sessions.
function tmp() {
  emulate -L zsh

  if (( $# > 1 )); then
    print -u2 -r -- 'Usage: tmp [--last | --list | --delete | --clean | --help]'
    return 2
  fi

  if (( $# == 1 )) && [[ $1 != --last && $1 != --list && $1 != --delete && $1 != --clean && $1 != --help ]]; then
    print -u2 -r -- "tmp: unknown argument: $1"
    print -u2 -r -- 'Usage: tmp [--last | --list | --delete | --clean | --help]'
    return 2
  fi

  case ${1-} in
    --help)
      print -r -- 'Usage: tmp [--last | --list | --delete | --clean | --help]

  tmp         Create a temporary directory and enter it.
  tmp --last  Enter the most recently created directory that still exists.
  tmp --list  List existing directories, newest first.
  tmp --delete Delete the current workspace and its contents after confirmation.
  tmp --clean Delete all listed directories and their contents after confirmation.
  tmp --help  Show this help.'
      return 0
      ;;
  esac

  local directory
  zstyle -s ':zim:tmp' directory directory || directory=${TMPDIR:-/tmp}/zsh-tmp-$UID
  if [[ -z $directory ]]; then
    print -u2 -r -- 'tmp: the configured directory is empty.'
    return 1
  fi
  directory=${directory:a}

  if (( $# == 0 )); then
    command mkdir -p -- "$directory" || return
    zmodload zsh/datetime || return
    local now=$EPOCHREALTIME stamp target
    local -x TZ=UTC
    strftime -s stamp '%Y-%m-%d_%H%M%S' ${now%.*} || return
    target=$(command mktemp -d "$directory/tmp-${stamp}.${now#*.}.XXXXXX") || return
    builtin cd -- "$target" || return
    print -r -- "$PWD"
    return 0
  fi

  # UTC timestamps sort by creation time, even if older directories are edited.
  # N allows an empty list; / selects directories; On sorts names descending.
  local -a directories=( "$directory"/tmp-*(N/On) )
  if (( ! $#directories )); then
    print -u2 -r -- 'tmp: no temporary directories found.'
    [[ $1 == --list || $1 == --clean ]]
    return
  fi

  case $1 in
    --last) builtin cd -- "$directories[1]" ;;
    --list) print -rl -- "${directories[@]}" ;;
    --clean|--delete)
      local workspace resolved current=${PWD:A}
      if [[ $1 == --delete ]]; then
        local target
        for workspace in "${directories[@]}"; do
          resolved=${workspace:A}
          if [[ $current == "$resolved" || $current == "$resolved"/* ]]; then
            target=$workspace
            break
          fi
        done
        if [[ -z $target ]]; then
          print -u2 -r -- 'tmp: the current directory is not inside a managed temporary workspace.'
          return 1
        fi
        directories=( "$target" )
        print -u2 -n -r -- "Delete $target and its contents? [y/N] "
      else
        print -u2 -n -r -- "Delete ${#directories} temporary directories and their contents in $directory? [y/N] "
      fi

      local answer
      read -r answer || return 1
      [[ $answer == [yY] || $answer == [yY][eE][sS] ]] || return 1

      # Leave a workspace before deleting it, including when entered via a symlink.
      for workspace in "${directories[@]}"; do
        workspace=${workspace:A}
        if [[ $current == "$workspace" || $current == "$workspace"/* ]]; then
          builtin cd -- "$directory" || return
          break
        fi
      done

      command rm -rf -- "${directories[@]}" || return
      if [[ $1 == --delete ]]; then
        print -r -- "Deleted temporary directory: $directories[1]"
      else
        print -r -- "Deleted ${#directories} temporary directories."
      fi
      ;;
  esac
}
