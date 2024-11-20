#!/usr/bin/env bash

selected=$(find ~/Desktop/ ~/Desktop/rust/ ~/Desktop/go/ /mnt/ /home/ /mnt/Data/Personal/ /mnt/Data/configs/ /mnt/Data/Personal/programmingPractice /mnt/Data/Personal/webDev /mnt/Data/Personal/cohort3/ -mindepth 1 -maxdepth 1 -type d | fzf)
selected_name=$(basename "$selected") # just extracting the name of the session

# checks if user cancled without selecting and kills the command
if [[ $selected_name == "" ]]; then
    exit 1
fi

tmux has-session -t="$selected_name" 2>/dev/null

# $? holds the exit status of the last executed command
if [ $? != 0 ]; then
    # the -d tag is VERY IMP! this creats a new session in detached mode
    tmux new-session -d -s "$selected_name" -c "$selected"
fi

tmux switch-client -t "$selected_name" 2>/dev/null

if [ $? != 0 ]; then
    tmux attach -t "$selected_name"
fi
