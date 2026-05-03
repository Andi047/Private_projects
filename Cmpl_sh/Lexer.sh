#!/bin/bash
#
# Lexer

source ./Token.sh

#peek="" # einzelner char (ist jedoch String)
#stream="" # StringBuffer des gesamten Quelltexts

file="$1"
stream="$(<"$file")"
length=${#stream}
index=0

#consume   # initalisiere peek mit 1. Zeichen
#nextToken # Starte Lexer

function consume() {
  if (( index < ${#stream} )); then
    index=$((index + $1))
    char="${stream:$index:1}"
  else
    echo "Fehler im consume"
    return 1;
  fi
}


#function match() {
#  local c="$1"
#  consume 1
#  if [[ "$peek" == "$c" ]]; then
#    return 0;
#  else
#    #rollback
#    return 1;
#  fi
#}


function whitespace() {
  while [[ $char == " " || $char == $'\t' || $char == $'\n' ]]; do
    consume 1
  done
}


#function rollback() {
  #if ((index > 0)); then
    #echo "Roll back error"
    #((index--))
    #peek="${stream:$index:1}"
  #fi
#}


function NAME() {
  local buffer=""
  while isLetter "$char" || isDigit "$char" || [[ $char == "-" ]]; do
    buffer+="$char"
    consume 1
  done

  case "$buffer" in
    "def") echo "TOKEN DEF: $buffer" ;;
    "defn") echo "TOKEN DEFN: $buffer" ;;
    "print") echo "TOKEN PRNT: $buffer" ;;
    "let") echo "TOKEN LET: $buffer" ;;
    "if") echo "TOKEN IF: $buffer" ;;
    "do") echo "TOKEN DO: $buffer" ;;
    "true") echo "TOKEN BOOL: $buffer" true ;;
    "false") echo "TOKEN BOOL: $buffer" false ;;
    *) echo "TOKEN ID: $buffer" ;;
  esac
}


function commentary() {
  while [[ $char != $'\n' && -n $char ]]; do
    consume 1
  done
}


function NUMBER() {
  local buffer=""

  while isDigit "$char"; do
    buffer+="$char"
    consume 1
  done
  # notwendig für NEG_NUM
  echo "$buffer"
}


function NEG_NUM() {
  consume 1
  if isDigit "$char"; then
    local num
    num=$(NUMBER)
    echo "TOKEN INT -$num"
  else
    echo "TOKEN SUB"
  fi
}


function STRING() {
  consume 1 # konsumiert 1x "
  local buffer=""

  while [[ $char != '"' && -n $char ]]; do
    buffer+="$char"
    consume 1
  done

  if [[ $char == '"' ]]; then
    consume 1 # grenzt mit 2tem " ein
    echo "TOKEN STR: $buffer"
  else
    echo "ERROR: incomplete String"
    return 1;
  fi
}


function isLetter() {
  [[ "$1" =~ [a-zA-Z] ]];
}


function isDigit() {
  [[ "$1" =~ [0-9] ]];
}


function nextToken() {

  while (( index < length )); do
    char="${stream:index:1}"

    case $char in
      " " | $'\t' | $'\n') whitespace; continue ;;

      ";")
        if [[ "${stream:index+1:1}" == ";" ]]; then
          commentary
          continue
        else
          echo "ERROR: incomplete comment declaration" >&2
          return 1;
        fi ;;

      "(") echo "TOKEN LBRACK: ${TOKEN[LBRACK]}"; consume 1 ;;
      ")") echo "TOKEN RBRACK: ${TOKEN[RBRACK]}"; consume 1 ;;
      "+") echo "TOKEN ADD: ${TOKEN[ADD]}"; consume 1 ;;
      "*") echo "TOKEN MUL: ${TOKEN[MUL]}"; consume 1 ;;
      "/") echo "TOKEN DIV: ${TOKEN[DIV]}"; consume 1 ;;
      "=") echo "TOKEN EQU: ${TOKEN[EQU]}"; consume 1 ;;
      "<") echo "TOKEN LESS: ${TOKEN[LESS]}"; consume 1 ;;
      ">") echo "TOKEN GRE: ${TOKEN[GRE]}"; consume 1 ;;
      "-") NEG_NUM; ;;
      '"') STRING; ;;

      *)
        if isDigit "$char"; then
          local num
          num="$(NUMBER)"
          echo "TOKEN NUM: $num"
        elif isLetter "$char"; then
          NAME
        else
          echo "ERROR: invalid char: '$char'" >&2
        fi
        consume 1
        continue ;;
    esac
  done

  echo "TOKEN EOF"
}

nextToken "$@"
