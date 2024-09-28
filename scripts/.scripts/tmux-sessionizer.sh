#!/usr/bin/env bash

selected=$(find ~/Desktop/ ~/Desktop/rust/ ~/Desktop/go/ /mnt/ /home/ /home/harsh/PC/ /mnt/Data/Personal/ /mnt/Data/configs/ /mnt/Data/Personal/programmingPractice /mnt/Data/Personal/webDev /mnt/Data/Personal/cohort3/ -mindepth 1 -maxdepth 1 -type d | fzf)
selected_name=$(basename "$selected") # just extracting the name of the session

# checks if user cancled without selecting and kills the command
if [[ $selected_name == "" ]]; then
    exit 1
fi

tmux has-session -t="$selected_name" 2>/dev/null

# $? holds the exit status of the last executed command
if [ $? != 0 ]; then
    # the -d tag is VERY IMP! this creats a new session in detached mode
    tmux new-session -d -s "$selected_name"
fi

# attaches to selected session if it didn't existed before then it was created in the above if statement
tmux switch-client -t "$selected_name"
