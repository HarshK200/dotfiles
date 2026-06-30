#!/usr/bin/env bash

# NOTE: SUB-DIRECTORIES INCLUDED but not the directory itself
directories=(
    "/c/Users/Harsh/Desktop/"
    "/c/Users/Harsh/Desktop/dev"
    "/c/Users/Harsh/Desktop/win-work-dev"
)

# NOTE: SUB-DIRECTORIES NOT INCLUDED
extra_directories=(
    "/c/Users/Harsh/Desktop/"
    "/c/Users/Harsh/Desktop/dev"
    "/c/Users/Harsh/.dotfiles/nvim/.config/nvim"
    "/c/Users/Harsh/.dotfiles"
    "/d"
)

# Find the subdirectories
found_subdirs=$(printf "%s\n" "${directories[@]}" | xargs -I {} find {} -mindepth 1 -maxdepth 1 -type d 2>/dev/null)

# Combine everything cleanly
all_dirs=$(printf "%s\n%s" "$found_subdirs" "$(printf "%s\n" "${extra_directories[@]}")")

# Pipe to fzf for selection
selected=$(echo "$all_dirs" | fzf)

# If the user cancels (escapes fzf), exit cleanly without doing anything
if [[ -z "$selected" ]]; then
    return 0 2>/dev/null || exit 0
fi

# Change directory directly in the active shell context
cd "$selected"
