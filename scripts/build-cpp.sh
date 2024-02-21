#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    currentdirectory=$(pwd)
fi

selectedFile=$(find $currentdirectory/*.cpp | fzf)
filename=$(basename "$selectedFile" .cpp)

if [[ -z $selectedFile ]]; then
    exit 0
fi

#Builds the cpp file
g++ "$selectedFile" -o "$filename"
#Runs the cpp file
./$filename
