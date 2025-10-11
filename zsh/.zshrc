# ===========================
# Configuración de Oh My Zsh
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
)

# Cargar Oh My Zsh
source $ZSH/oh-my-zsh.sh

# ===========================
# Configuración extra
# ===========================

# Colores 256
export TERM="xterm-256color"

# Historial
HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.zsh_history

# Alias útiles
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Autocompletado mejorado
autoload -Uz compinit
compinit

# Rutas personalizadas (si quieres añadir otras rutas de binarios)
# export PATH="$HOME/bin:$PATH"

# ===========================
# Fin de configuración
# ===========================

# Created by `pipx` on 2025-10-10 05:56:34
export PATH="$PATH:/home/adrian/.local/bin"
