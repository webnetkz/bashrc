#!/bin/bash

rsync -u .my_init ~/.my_init;
rsync -u .my_git ~/.my_git;
rsync -u .my_npm ~/.my_npm;
rsync -u .my_aliases ~/.my_aliases;
rsync -u .my_docker ~/.my_docker


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
source ~/.my_init
source ~/.my_aliases
source ~/.my_git
source ~/.my_npm
source ~/.my_docker
