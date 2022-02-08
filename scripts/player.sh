#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$CURRENT_DIR/helpers.sh"

main() {
    local player_style_left=$(get_tmux_option "@player-style-left")
    local player_style_right=$(get_tmux_option "@player-style-right")
    local player_format=$(get_tmux_option "@player-format")
    local max_length=$(get_tmux_option "@player-max-length")

    if [ -f "$(which playerctl)" ];then
        local value=$(playerctl metadata -f "$player_format" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' | sed -re "s/(.{$max_length}).*/\1.../")
    fi

    if [ -n "$value" ];then
        echo -n "${player_style_left}${value}${player_style_right}"
    fi
}

main
