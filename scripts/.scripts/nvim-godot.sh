#!/usr/bin/env bash

query="$1"

# Base directory containing the projects
# YOU NEED TO CHANGE THIS
basePath="$HOME/Desktop/godot_projects/"

# Ensure the base path exists
if [[ ! -d "$basePath" ]]; then
    echo "Error: Base path $basePath does not exist." >&2
    exit 1
fi

# Find the folder that matches the query
matchingFolders=($(find "$basePath" -mindepth 1 -maxdepth 1 -type d -name "$query*" 2>/dev/null))

if [[ ${#matchingFolders[@]} -eq 0 ]]; then
    echo "Error: No folder found matching '$query'." >&2
    exit 1
elif [[ ${#matchingFolders[@]} -gt 1 ]]; then
    echo "Error: Multiple folders match '$query'. Please refine your query." >&2
    for folder in "${matchingFolders[@]}"; do
        echo "$folder"
    done
    exit 1
fi

# Get the matched folder path
projectPath="${matchingFolders[0]}"

# Run Neovim in the matched folder
echo "Opening Neovim in $projectPath"
cd "$projectPath" || exit 1
# YOU MIGHT NEED TO CHANGE THIS IF YOU PUT ANOTHER IP OR FILEPATH
nvim . --listen 127.0.0.1:55432
