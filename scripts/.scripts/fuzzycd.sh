#!/bin/bash
target=$(find . -type d -not -path '*/.git/*' -not -path '*/.git' -not -path '*/node_modules/*' -not -path '*/.github' -not -path '*/.github/*'| fzf)

if [ -n "$target" ]; then
    cd "$target" || exit
else
    echo "No directory selected."
fi
