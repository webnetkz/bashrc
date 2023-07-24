#!/bin/bash

cp --update .my_init ~/.my_init;
cp --update .my_git ~/.my_git;
cp --update .my_npm ~/.my_npm;
cp --update .my_aliases ~/.my_aliases;

line_to_add=". ~/.my_init"      
if [ -f ~/.bashrc ]; then
    if ! grep -Fxq "$line_to_add" ~/.bashrc; then
        echo "$line_to_add" >> ~/.bashrc
        echo "Инстраляция успешно произведена ~/.bashrc."
    else
        echo "Настройки уже присутствует в файле ~/.bashrc."
    fi
else
    echo "Файл ~/.bashrc не существует."
fi

source ~/.bashrc