function green() {
   printf "\e[32m%s\e[0m\n" "$@"
}


function yellow() {
   printf "\e[33m%s\e[0m\n" "$@"
}


function red() {
   printf "\e[31m%s\e[0m\n" "$@"
}


function bold() {
   printf "\e[1m%s\e[0m\n" "$@"
}


function error_and_die {
  # Exit on failure
  red "ERROR: ${1}"
  exit 1
}

function stop_processing {
  # Exit on failure
  bold "${1}"
  exit 0
}
