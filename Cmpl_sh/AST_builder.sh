#!/bin/bash
#
# Aus Java: Expr-Builder

function build_INT_literal() {
    local val="$1"
    declare -A node=([type]="IntLiteral" [val]="$val")
    echo "$(declare -p node)"
}

function build_STR_literal() {
    local val="$1"
    declare -A node=([type]="StrLiteral" [val]="$val")
    echo "$(declare -p node)"
}

function build_VAR_literal() {
    local val="$1"
    declare -A node=([type]="Variable" [val]="$val")
    echo "$(declare -p node)"
}


# VISITOR-Funktion
function visit_literals() {
    local node_decl="$1"
    eval "$node_decl" # erzeugt assoziat. Array "node"

    case "${node[type]}" in
      IntLiteral)
        echo "Besuch IntLiteral mit Wert ${node[val]}" ;;
      StrLiteral) ;;
      Variable) ;;
      *)
        echo "Unbekannter Typ: ${node[type]}"
        exit 1
        ;;
    esac
}


function build_DEF() {
    local name="$1"
    local val_node="$2" # AST-Knoten als String
    declare -A node=([type]="DEF" [name]="$name" [val]="$val_node")
    echo "$(declare -p node)"
}

function visit_DEF() {
    local node_decl="$1"
    eval "$node_decl"
    echo "Definiere ${node[name]} ="
    visit "${node[value]}"
}