#!/usr/bin/env bash

CWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$CWD/helpers.sh"

#: Options
short_max_length_string="@short_length"
short_append_chars_string="@short_append_chars"

#: Default values for options
short_max_length="40"
short_append_chars="..."

#: Define players to poll for metadata
player1="spotify"
player2="DeaDBeeF"

#: Check if player is running and retrieve metadata
check_player() {
    local player=$1
    result=$(playerctl -p "$player" metadata --format "{{ artist }} - {{ title }}" 2>&1)
    
    if [[ $result == *"No players found"* ]]; then
        echo "n/a"
    else
        echo "$result"

    fi
}

main() {
  local full shortened info_char_count max_chars append
  max_chars=$(get_tmux_option "$short_max_length_string" "$short_max_length")

  full=$(check_player "$player1")

  if [[ "$full" == 'n/a' ]]; then
  full=$(check_player "$player2")
  fi

  full=$(echo "$full" | tr '[:upper:]' '[:lower:]')
  shortened=${full:0:$max_chars}
  info_char_count=${#full}
  local append=""

  if [[ $info_char_count -gt $max_chars ]]; then
    append=$(get_tmux_option "$short_append_chars_string" "$short_append_chars")
  fi

  echo "$shortened$append"
}

main
