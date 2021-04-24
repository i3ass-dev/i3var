#!/usr/bin/env bash

main(){

  action=$1 variable_name=$2 value_to_set=$3

  [[ $action =~ get|set && ${#@} -gt 1 ]] \
    || ERX "$* not a valid command"

  re="\"${variable_name}=([^\"]*)\""

  [[ $(i3-msg -t get_marks) =~ $re ]] \
    && current_value=${BASH_REMATCH[1]}

  [[ $action = get ]] && {
    [[ $current_value ]] && echo "$current_value"
    exit
  }

  new_mark="${variable_name}=$value_to_set"
  old_mark="${variable_name}=$current_value"

  [[ $(i3-msg -t get_tree) =~ ^\{\"id\":([0-9]+).+ ]] \
      && root_id=${BASH_REMATCH[1]}

  # this will remove the old mark
  [[ $current_value ]] \
    && i3-msg -q "[con_mark=$old_mark] mark --toggle --add $old_mark"

  [[ $value_to_set ]] && {
    i3-msg -q "[con_id=$root_id] mark --add $new_mark"
  }
}

___source="$(readlink -f "${BASH_SOURCE[0]}")"  #bashbud
___dir="${___source%/*}"                        #bashbud
source "$___dir/init.sh"                        #bashbud
main "$@"                                       #bashbud
