################# DO NOT MODIFY THIS FILE #######################
####### PLACE YOUR CONFIGS IN ~/.config/ezsh/zshrc FOLDER #######
#################################################################

# ========================================
# ezsh Configuration Loader
# ========================================

# This file is created by ezsh setup.
# Place all your .zshrc configurations / overrides in a single or multiple files under ~/.config/ezsh/zshrc/ folder
# Your original .zshrc is backed up at ~/.zshrc-backup-%y-%m-%d

# Load ezsh configurations
source "$HOME/.config/ezsh/ezshrc.zsh"

# ========================================
# Load User Configurations
# ========================================

# Any zshrc configurations under the folder ~/.config/ezsh/zshrc/ will override the default ezsh configs.
# Place all of your personal configurations over there
ZSH_CONFIGS_DIR="$HOME/.config/ezsh/zshrc"

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

# Source oh-my-zsh.sh so that any plugins added in ~/.config/ezsh/zshrc/* files also get loaded
source $ZSH/oh-my-zsh.sh

# ========================================
# Post Oh My Zsh Configuration
# ========================================

# Configurations that depend on oh-my-zsh plugins or must be loaded after oh-my-zsh.sh

# Source fzf.zsh, otherwise Ctrl+r is overwritten by ohmyzsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPS="--extended"
