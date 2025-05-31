#!/usr/bin/env bash

# NOTE: SUB-DIRECTORIES INCLUDED but not the directory itself
directories=(
    "$HOME/dev/"
    "$HOME/dev/go/"
    "/media/harsh/DATA/code/"
    "/media/harsh/DATA/code/webDev/"
    "/media/harsh/DATA/code/cohort3/"
)

# NOTE: SUB-DIRECTORIES NOT INCLUDED
extra_directories=(
    "/home/harsh/.dotfiles"
    "$HOME/.scripts"
    "/media/harsh/DATA/"
)

found_subdirs=$(printf "%s\n" "${directories[@]}" | xargs -I {} find {} -mindepth 1 -maxdepth 1 -type d 2>/dev/null)
all_dirs=$(echo -e "$found_subdirs\n$(printf "%s\n" "${extra_directories[@]}")")

selected=$(echo "$all_dirs" | fzf)
selected_name=$(basename "$selected") # just extracting the name of the session
selected_name=${selected_name//./_}

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
