################# DO NOT MODIFY THIS FILE #######################
####### PLACE YOUR CONFIGS IN ~/.config/qzsh/zshrc FOLDER #######
#################################################################

# ========================================
# qzsh Configuration Loader
# ========================================

# This file is created by qzsh setup.
# Place all your .zshrc configurations / overrides in a single or multiple files under ~/.config/qzsh/zshrc/ folder
# Your original .zshrc is backed up at ~/.zshrc-backup-%y-%m-%d

# Load qzsh configurations
source "$HOME/.config/qzsh/qzshrc.zsh"

# ========================================
# Load User Configurations
# ========================================

# Any zshrc configurations under the folder ~/.config/qzsh/zshrc/ will override the default qzsh configs.
# Place all of your personal configurations over there
ZSH_CONFIGS_DIR="$HOME/.config/qzsh/zshrc"

if [ "$(ls -A $ZSH_CONFIGS_DIR)" ]; then
    for file in "$ZSH_CONFIGS_DIR"/* "$ZSH_CONFIGS_DIR"/.*; do
        # Exclude '.' and '..' from being sourced
        if [ -f "$file" ]; then
            source "$file"
        fi
    done
fi

# ========================================
# Source Oh My Zsh
# ========================================

# Source oh-my-zsh.sh so that any plugins added in ~/.config/qzsh/zshrc/* files also get loaded
source $ZSH/oh-my-zsh.sh

# ========================================
# Post Oh My Zsh Configuration
# ========================================

# Configurations that depend on oh-my-zsh plugins or must be loaded after oh-my-zsh.sh

# Source fzf.zsh, otherwise Ctrl+r is overwritten by ohmyzsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPS="--extended"

