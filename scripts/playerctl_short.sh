#!/usr/bin/env bash

CWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$CWD/helpers.sh"

#: Options
short_max_length_string="@short_length"
short_append_chars_string="@short_append_chars"

#: Default values for options
short_max_length="40"
short_append_chars="..."

main() {
  local full shortened info_char_count max_chars append
  max_chars=$(get_tmux_option "$short_max_length_string" "$short_max_length")
  full=$(playerctl -p spotify metadata --format "{{ artist }} - {{ title }}" | tr '[:upper:]' '[:lower:]')
  shortened=${full:0:$max_chars}
  info_char_count=${#full}
  local append=""

  if [[ $info_char_count -gt $max_chars ]]; then
    append=$(get_tmux_option "$short_append_chars_string" "$short_append_chars")
  fi

  if ! playerctl -p spotify metadata; then
  echo "n/a"
  else
  echo "$shortened$append"
  fi
  
}

main
