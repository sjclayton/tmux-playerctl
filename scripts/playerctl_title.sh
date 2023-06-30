#!/usr/bin/env bash

main() {
  playerctl -p spotify metadata --format "{{ title }}"
}

main
