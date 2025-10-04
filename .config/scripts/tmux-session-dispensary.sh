#!/bin/bash

DIRS=(
	"$HOME/dev"
	"$HOME/index"
	"$HOME/index/2-Projects"
	"$HOME/index/2-Projects/2.1-school_courses"
	"$HOME/.config"
    "$HOME"
)

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(fd . "${DIRS[@]}" --type=dir --max-depth=1 --full-path --base-directory $HOME \
        | sed "s|^$HOME/||" \
        | sk --margin 10% --color="bw")

    [[ $selected ]] && selected="$HOME/$selected"
fi

[[ ! $selected ]] && exit 0

selected_name=$(basename "$selected" | tr . _)

if ! tmux has-session -t "$selected_name"; then
    tmux new-session -ds "$selected_name" -c "$selected"
    tmux select-window -t "$selected_name:1"
fi

tmux switch-client -t "$selected_name"
