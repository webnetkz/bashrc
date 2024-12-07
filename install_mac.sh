#!/bin/bash

rsync -u .[^.]* ~/

for file in .[^.]*; do
    if [ -f "$file" ]; then
        line_to_add=". ~/$file"
        if ! grep -Fxq "$line_to_add" ~/.zshrc; then
            echo "$line_to_add" >> ~/.zshrc
        fi
    fi
done

cd ~/ source .zshrc
echo "Success"

