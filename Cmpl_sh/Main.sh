#!/bin/bash
#
# Startpunkt des Compilers

source ./Lexer.sh

#index=0

function main() {
  local file="$1"

  # Einlesen Datei
  if [[ -z "$file" ]]; then
    read -p "Bitte Datei angeben: " file
  fi

  if [[ ! -f "$file" ]]; then
    echo "Fehler: Datei '$file' nicht gefunden." >&2
    exit 1
  fi

  stream="$(<"$file")"
  #index=0
  #consume 1 # peek initia.
  nextToken

  #echo "DEBUG: file='$file' stream_len=${#stream}" >&2
  #printf 'DEBUG: first 40 chars: %q\n' "${stream:0:40}" >&2
  #echo "DEBUG: index=$index char='$char'" >&2

  # Tokenstrom initialisieren
  #token="$(nextToken)"
  #echo $token
  #while [[ "$token" != "[EOF] EOF" ]]; do
    #echo "$token"
    #token="$(nextToken)"
  #done
}

main "$@" # $@ ermöglicht Mitgabe von params


