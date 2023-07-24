#!/bin/bash

rsync -u .my_init ~/.my_init;
rsync -u .my_aliases ~/.my_aliases;
rsync -u .my_git ~/.my_git;
rsync -u .my_npm ~/.my_npm;

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
source ~/.my_init
source ~/.my_aliases
source ~/.my_git
source ~/.my_npm