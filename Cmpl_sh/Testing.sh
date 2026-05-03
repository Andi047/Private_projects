#!bin/bash

function Token_Test() {
  declare -A TOKEN_TYPES=(
    [ID]="id" [ADD]="+"
  )

  declare -A TOKEN_BY_VALUE
  for k in "${!TOKEN_TYPES[@]}"; do
    TOKEN_BY_VALUE["${TOKEN_TYPES[$k]}"]="$k"
  done

  #TOKEN() {
  #  local type="$1"
  #  local value="$2"
  #  echo "[$type] $value"
  #}

  test="+"

  #echo "TOKEN (type): ${TOKEN_TYPES[$]="+"}"
  echo "TOKEN (char): ${TOKEN_TYPES[ADD]}"
  #echo TOKEN_TYPES[ID]
  echo ${TOKEN_TYPES[ADD]}
  echo "${TOKEN_TYPES[ID]}"

  #if [[ $test == ${TOKEN_TYPES[ADD]} ]]; then
  #  echo "Is true: TOKEN: ${TOKEN_TYPES[$]="+"}"
  #fi

  echo ${TOKEN_TYPES[@]}
}

function read_File() {
  local file="$1"
  local peek=""
  local index=0
  stream="$(<"$file")"

  echo "Datei ist: $file"

  echo "Länge des Texts in Anzahl char: ${#stream}"

  until (( $index == ${#stream} )); do
    char="${stream:$index:1}"
    printf 'Zeichen %d: %s\n' "$index" "$char"
    index=$((index+1))
  done
}



function start() {
  local file="$1"
  local index=0
  stream="$(<"$file")"
  length=${#stream}

  declare -A TOKEN=(
    [COMM]=";;"
    [ADD]="+"
  )

  function consume() {
    index=$((index + $1))
    char="${stream:$index:1}"
  }

  function whitespace() {
    while [[ $char == " " || $char == $'\t' || $char == $'\n' ]]; do
      consume 1
    done
  }

  function commentary() {
    while [[ $char != $'\n' && -n $char ]]; do
      consume 1
    done
  }

  
  while (( index < length )); do
    char="${stream:index:1}"

    case $char in
      " " | $'\t' | $'\n') whitespace; continue ;;

      ";") if [[ "${stream:index+1:1}" == ";" ]]; then
      #";") if [[ "${stream:$((index+1)):1}" ]]; then
             commentary
             continue
           fi ;;

      "+") echo "TOKEN ADD: $char"
           consume 1 ;;
      *)
        if [[ $char == 1 ]]; then
          echo "EINS gefunden: $char"
        fi
        consume 1
        continue ;;
    esac
  done

}

#Token_Test
#read_File "$@"
start "$@"





