#!/bin/bash

cp -u .init ~/.init;
cp -u .gitcommands ~/.gitcommands

line_to_add=". ~/.init"      
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
