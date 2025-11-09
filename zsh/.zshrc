# ===========================
# Oh My Zsh + Colorls Setup
# ===========================

# Ruta de Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# Tema de la terminal
ZSH_THEME="agnoster"

# Plugins a cargar
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  docker
  npm
)

# Colores para ls y colorls
eval "$(dircolors ~/.dircolors)"

# ===========================
# Cargar Oh My Zsh
# ===========================
source $ZSH/oh-my-zsh.sh

# ===========================
# Resaltado de sintaxis Zsh
# ===========================
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
ZSH_HIGHLIGHT_STYLES[command]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[error]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=magenta,bold'

autoload -Uz compinit
compinit

# ===========================
# Variables de entorno
# ===========================
export TERM="xterm-256color"

# Historial
HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.zsh_history

# ===========================
# Alias de colorls (reemplaza ls)
# ===========================

# Instalar Ruby (si no lo tienes)
# sudo apt update
# sudo apt install ruby-full -y
# Instalar la gem colorls
# sudo gem install colorls


alias ls='colorls --group-directories-first'
alias ll='colorls -lh --group-directories-first'
alias la='colorls -a --group-directories-first'
alias l='colorls -CF --group-directories-first'

# ===========================
# Alias útiles
# ===========================

# Navegación
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias c='clear'
alias home='cd ~'

# Listado y búsqueda
alias grep='grep --color=auto'
alias f='find . -name'  # ejemplo: f "*.txt"

# Git
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
alias gco='git checkout'

# Sistema y procesos
alias actualizar='sudo apt update && sudo apt upgrade -y'
alias ports='sudo lsof -i -P -n | grep LISTEN'
alias psg='ps aux | grep'
alias dfh='df -h'
alias mem='free -h'

# ChatGPT CLI
alias gpt="chatgpt"

# Android Studio
alias android='cd ~/android-studio/bin && ./studio'

# ===========================
# PATH adicional
# ===========================
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:/snap/bin"

# API key OpenAI (si la usas)
export OPENAI_API_KEY="TU_API_KEY_AQUI"

# ===========================
# Colorls Theme (opcional)
# ===========================
# export COLORLS_THEME="dark"

# ===========================
# Fin de configuración
# ===========================

