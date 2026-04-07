#!/bin/bash
FILE="$*"
DIR="$(dirname "$FILE")"
cd "$DIR"
if [ "$#" -eq "0" ]; then
  tmux new-session "nvim" \; \
    split-window -v -l 20%
else
  tmux new-session "nvim \"$FILE\"" \; \
    split-window -v -l 20%
fi
