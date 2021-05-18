#!/usr/bin/env bash

main(){

  action=$1 variable_name=$2 value_to_set=$3

  [[ $action =~ get|set && ${#@} -gt 1 ]] \
    || ERX "$* not a valid command"

  : "${json:=${__o[json]:-$(i3-msg -t get_tree)}}"

  re='^\{"id":([0-9]+)[^[]+\[([^]]*"'"${variable_name}"'=([^"]*)"[^]]*)?'
  [[ $json =~ $re ]] || ERX "no vars found"

  root_id=${BASH_REMATCH[1]}
  current_value=${BASH_REMATCH[3]}

  if [[ $action = set ]]; then

    new_mark="${variable_name}=$value_to_set"
    old_mark="${variable_name}=$current_value"

    # this will remove the old mark
    [[ $current_value ]] \
      && msg+="[con_id=$root_id] mark --toggle --add $old_mark;"

    [[ $value_to_set ]] \
      && msg+="[con_id=$root_id] mark --add $new_mark"

    i3-msg -q "$msg"

  elif [[ $current_value ]]; then

    echo "$current_value"
  fi
}

___source="$(readlink -f "${BASH_SOURCE[0]}")"  #bashbud
___dir="${___source%/*}"                        #bashbud
source "$___dir/init.sh"                        #bashbud
main "$@"                                       #bashbud
