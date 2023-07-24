#!/bin/bash

cp -u .my_init ~/.my_init;
cp -u .my_git ~/.my_git;
cp -u ./.my_npm ~/.my_npm;
cp -u .my_aliases ~/.my_aliases;

line_to_add=". ~/.my_init"      
if [ -f ~/.bash_profile ]; then
    if ! grep -Fxq "$line_to_add" ~/.bash_profile; then
        echo "$line_to_add" >> ~/.bash_profile
        echo "Инстраляция успешно произведена ~/.bash_profile."
    else
        echo "Настройки уже присутствует в файле ~/.bash_profile."
    fi
else
    echo "Файл ~/.bash_profile не существует."
fi

source ~/.bash_profile