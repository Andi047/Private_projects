#!/bin/bash

declare -A TOKEN=(
  [EOF]="EOF"
  [ID]="ID" [INT]="INT" [STR]="STR" [BOOL]="BOOL"
  [NEWL]=$'\n' [WS]=" "
  [ADD]="+" [SUB]="-" [MUL]="*" [DIV]="/"
  [EQU]="=" [GRE]=">" [LESS]="<"
  [DEF]="def" [DEFN]="defn" [LET]="let" [IF]="if" [DO]="do" [PRNT]="print"
  [LBRACK]="(" [RBRACK]=")"
)


#TOKEN() {
#  local type="$1"
#  local value="$2"
#  echo "[$type] $value"
#}
