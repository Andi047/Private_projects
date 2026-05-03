#!/bin/bash
#
# Parser

source ./Token.sh

# TODO: Umwandlung Tokenstrom in Array-List

# TODO: Liste benötigt, die TOKEN aus Lexer hat
tokenList=(
  [LBRACK]="(", [DEF]="def", [ID]="x",
  [INT]="4", [RBRACK]=")", [EOF]="EOF"
)

# Fungiert als ArrayList-Typ
expressions=()


function consume() {
  local expected=$1
  if [[ $currentToken == $expected ]]; then
    local old=$currentToken
    currentToken=$(nextToken)
    echo $old
  else
    # throw error...
    echo "Erwartetes Token: $expected, gefunden: $currentToken"
    return 1;
  fi
}


function parse() {
    while [[ -n $tokenList ]]; do # TODO: Umbau erforderlich 
      expressions+=("$(parseExpr)")
    done
}

function parseExpr() {
    case $tokenList in
      INT) parseInt ;;
      STR) parseStr ;;
      BOOL) parseBool ;;
      ID) parseId ;;
      LBRACK) parse_sExpr ;;

      *)
      echo "Erwartet: Ausdruck, gefunden: $currentToken"
      return 1 ;;
    esac
}

function parse_sExpr() {
  consume "TOKEN LBRACK"

  local result
  # Expr result = switch (currentToken.type)
  case $currentToken in
    DEF) $result=$(parseDef) ;;
    DEFN) $result=$(parseDefn) ;;
    LET) $result=$(parseLet) ;;
    IF) $result=$(parseIf) ;;
    DO) $result=$(parseDo) ;;
    ID | ADD | SUB | MUL | DIV | EQ | LESS | GRE) $result=$(parseCall) ;;
    *)
      echo "Erwartet: ID, Operator oder Keyword nach ( , gefunden: $currentToken" >&2
      return 1 ;;
  esac

  consume "TOKEN RBRACK"
  echo "$result"
}


function parseDef() {
  consume "DEF"
  local name=$(consume "ID") #.lexeme()
  local value=$(parseExpr)
  echo "DEF(name=$name, value=$value)"
}


function parseDefn() {
  consume "DEFN"
  local name=$(consume "ID") #.lexeme()

  consume "LBRACK"
  local params=()
  while [[ $currentToken == "ID" ]]; do
    # params.add(consume(tokentype.ID).lexeme());
    params+=("$(consume "ID")")
  done
  consume "RBRACK"

  local body=$(parseExpr) # Expr body = parseExpr();
  # Expr.Defn(name, params, body)
  echo "DEFN(name=$name, params=[${params[*]}], body=$body)"
}


function parseLet() {
  consume "LET"
  consume "LBRACK"

  local bindings=() # List<Expr.Binding> bindings = new ArrayList<>()
  while [[ $currentToken == "ID" ]]; do
    local varName=$(consume "ID") # .lexeme();
    # Expr varValue = parseExpr();
    local varValue=$(parseExpr)
    # bindings.add(new Expr.Binding(varName, varValue));
    bindings+=("Binding(name=$varName, value=$varValue)")
  done
  consume "RBRACK"

  local body=$(parseExpr) # Expr body = parseExpr();
  # Expr.Let(bindings, body);
  echo "LET(bindings=[${bindings[*]}, body=$body)"
}


function parseIf() {
  consume "IF"
  local cond=$(parseExpr)
  local thenBranch=$(parseExpr)

  local elseBranch="" # Expr elseBranch = null;
  if [[ $currentToken != "RBRACK" ]]; then
    elseBranch=$(parseExpr)
  fi

  # Expr.If(cond, thenBranch, elseBranch);
  echo "IF(cond=$cond, then=$thenBranch, else=$elseBranch)" 
}


function parseDo() {
  consume "DO"
  local exprs=()
  while [[ $currentToken != "RBRACK" && $currentToken != "EOF" ]]; do
    exprs+=("$(parseExpr)")
  done

  # Expr.Do(exprs)
  echo "DO(exprs=[${exprs[*]}])"
}


function parseCall() {
  local funcName=$(currentToken)
  consume "$1" # alles konsumieren TODO korrekt ?
  local args=()
  while [[ $currentToken != "RBRACK" && $currentToken != "EOF" ]]; do
    args+=("$(parseExpr)")
  done
  # return new Expr.Call(funcName, args);
  echo "CALL(func=$1,args=[${args[*]}])"
}


function parseInt() {
  # int val = (int) currentToken.literal();
  local val=$(literal) TODO
  consume "INT"
  # return nex Expr.IntLiteral(val);
  echo "INT($val)"
}

# Funktionen für Literale
function parseString() {
  local val=$(literal)
  consume "STR"
  echo "STR($val)"
}

function parseBool() {
  local val=$(literal)
  consume "BOOL"
  echo "BOOL($val)"
}

function parseVariable() {
  local name=$(currentToken) #.literal()
  consume "ID"
  echo "ID($name)"
}



