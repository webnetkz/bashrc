#!/bin/bash

rsync -u ./.[^.]* ~/

for file in .[^.]*; do
    if [ -f "$file" ]; then
        line_to_add=". ~/$file"
        if ! grep -Fxq "$line_to_add" ~/.bashrc; then
            echo "$line_to_add" >> ~/.bashrc
        fi
    fi
done

source ~/.bashrc
echo "Success"

