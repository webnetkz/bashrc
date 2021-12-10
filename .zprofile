eval "$(/opt/homebrew/bin/brew shellenv)"
# Псевдонимы для GIT
COMMIT="update" # Название коммита по умолчанию
REP="rep"
alias gg='git status; git add --a; git commit -m $COMMIT; git status; git push;' # Добавить новый коммит
alias upbash='cd ~/; cp .bashrc ./bashrc/.bashrc; cd ~/bashrc/; gg;' # Обновить .bashrc
alias gcl='git clone https://github.com/webnetkz/$REP.git; git remote set-url origin git@github.com:webnetkz/$REP.git'


# Установка программ
alias newPC='apt install git nano htop wget net-tools;'

# Удобные инструменты
alias myip='wget eho0.me -qO -' # Получение текущего IP адреса
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'


