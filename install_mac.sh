#!/bin/bash

rsync -u .[^.]* ~/

for file in .[^.]*; do
    if [ -f "$file" ]; then
        line_to_add=". ~/$file"
        if ! grep -Fxq "$line_to_add" ~/.bash_profile; then
            echo "$line_to_add" >> ~/.bash_profile
        fi
    fi
done

cd ~/ source .bashrc_profile
echo "Success"

