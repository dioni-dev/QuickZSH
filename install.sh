#!/bin/bash

# ========================================
# Argument Parsing
# ========================================

# Flags to determine if the arguments were passed
cp_hist_flag=false
noninteractive_flag=false

# Loop through all arguments
for arg in "$@"
do
    case $arg in
        --cp-hist|-c)
            cp_hist_flag=true
            ;;
        --non-interactive|-n)
            noninteractive_flag=true
            ;;
        *)
            # Handle any other arguments or provide an error message
            ;;
    esac
done

# ========================================
# Dependency Check and Installation
# ========================================

# Check if zsh, git, and wget are installed
if command -v zsh &> /dev/null && command -v git &> /dev/null && command -v wget &> /dev/null; then
    echo -e "ZSH and Git are already installed\n"
else
    # Try to install dependencies using various package managers
    if sudo apt install -y zsh git wget autoconf || sudo pacman -S zsh git wget || sudo dnf install -y zsh git wget || sudo yum install -y zsh git wget || sudo brew install git zsh wget || pkg install git zsh wget ; then
        echo -e "zsh wget and git Installed\n"
    else
        echo -e "Please install the following packages first, then try again: zsh git wget\n" && exit
    fi
fi

# ========================================
# Backup Existing .zshrc
# ========================================

# Backup the current .zshrc if it exists
if mv -n ~/.zshrc ~/.zshrc-backup-$(date +"%Y-%m-%d"); then
    echo -e "Backed up the current .zshrc to .zshrc-backup-date\n"
fi

# ========================================
# Setup Directories
# ========================================

echo -e "The setup will be installed in '~/.config/qzsh'\n"
echo -e "Place your personal zshrc config files under '~/.config/qzsh/zshrc/'\n"
mkdir -p ~/.config/qzsh/zshrc

if [ -d ~/.quickzsh ]; then
    echo -e "\n PREVIOUS SETUP FOUND AT '~/.quickzsh'. PLEASE MANUALLY MOVE ANY FILES YOU'D LIKE TO '~/.config/qzsh' \n"
fi

# ========================================
# Install Oh My Zsh
# ========================================

echo -e "Installing oh-my-zsh\n"
if [ -d ~/.config/qzsh/oh-my-zsh ]; then
    echo -e "oh-my-zsh is already installed\n"
    git -C ~/.config/qzsh/oh-my-zsh remote set-url origin https://github.com/ohmyzsh/ohmyzsh.git
elif [ -d ~/.oh-my-zsh ]; then
    echo -e "oh-my-zsh is already installed at '~/.oh-my-zsh'. Moving it to '~/.config/qzsh/oh-my-zsh'\n"
    export ZSH="$HOME/.config/qzsh/oh-my-zsh"
    mv ~/.oh-my-zsh ~/.config/qzsh/oh-my-zsh
    git -C ~/.config/qzsh/oh-my-zsh remote set-url origin https://github.com/ohmyzsh/ohmyzsh.git
else
    git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git ~/.config/qzsh/oh-my-zsh
fi

# ========================================
# Copy Configuration Files
# ========================================

# Obtén el directorio del script actual
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cp -f "$SCRIPT_DIR/.zshrc" ~/
cp -f "$SCRIPT_DIR/qzshrc.zsh" ~/.config/qzsh/

# ========================================
# Setup Directories for Configurations and Cache
# ========================================

mkdir -p ~/.config/qzsh/zshrc  # Place your zshrc configurations over there
mkdir -p ~/.cache/zsh/  # Store zsh completion cache files here
mkdir -p ~/.fonts  # Create .fonts if it doesn't exist

# Move zsh completion dump files to cache directory
if [ -f ~/.zcompdump ]; then
    mv ~/.zcompdump* ~/.cache/zsh/
fi

# ========================================
# Install Plugins
# ========================================

# Function to install or update a git repository
install_or_update_repo() {
    local repo_url=$1
    local target_dir=$2

    if [ -d $target_dir ]; then
        cd $target_dir && git pull
    else
        git clone --depth=1 $repo_url $target_dir
    fi
}

# Install or update zsh-autosuggestions
install_or_update_repo https://github.com/zsh-users/zsh-autosuggestions ~/.config/qzsh/oh-my-zsh/plugins/zsh-autosuggestions

# Install or update zsh-syntax-highlighting
install_or_update_repo https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/qzsh/oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# Install or update zsh-completions
install_or_update_repo https://github.com/zsh-users/zsh-completions ~/.config/qzsh/oh-my-zsh/custom/plugins/zsh-completions

# Install or update zsh-history-substring-search
install_or_update_repo https://github.com/zsh-users/zsh-history-substring-search ~/.config/qzsh/oh-my-zsh/custom/plugins/zsh-history-substring-search

# ========================================
# Install Fonts
# ========================================

echo -e "Installing Nerd Fonts version of Hack, Roboto Mono, DejaVu Sans Mono\n"

wget -q --show-progress -N https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/HackNerdFont-Regular.ttf -P ~/.fonts/
wget -q --show-progress -N https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/RobotoMono/Regular/RobotoMonoNerdFont-Regular.ttf -P ~/.fonts/
wget -q --show-progress -N https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DejaVuSansMono/Regular/DejaVuSansMNerdFont-Regular.ttf -P ~/.fonts/

fc-cache -fv ~/.fonts

# ========================================
# Install Themes and Additional Plugins
# ========================================

# Install or update Powerlevel10k theme
install_or_update_repo https://github.com/romkatv/powerlevel10k.git ~/.config/qzsh/oh-my-zsh/custom/themes/powerlevel10k

# Install or update fzf
install_or_update_repo https://github.com/junegunn/fzf.git ~/.config/qzsh/fzf
~/.config/qzsh/fzf/install --all --key-bindings --completion --no-update-rc

# Install or update fzf-tab
install_or_update_repo https://github.com/Aloxaf/fzf-tab ~/.config/qzsh/oh-my-zsh/custom/plugins/fzf-tab

# Install or update marker
install_or_update_repo https://github.com/jotyGill/marker ~/.config/qzsh/marker

if ~/.config/qzsh/marker/install.py; then
    echo -e "Installed Marker\n"
else
    echo -e "Marker Installation Had Issues\n"
fi

# ========================================
# Install todo.txt-cli
# ========================================

if [ ! -L ~/.config/qzsh/todo/bin/todo.sh ]; then
    echo -e "Installing todo.sh in ~/.config/qzsh/todo\n"
    mkdir -p ~/.config/qzsh/bin
    mkdir -p ~/.config/qzsh/todo
    wget -q --show-progress "https://github.com/todotxt/todo.txt-cli/releases/download/v2.12.0/todo.txt_cli-2.12.0.tar.gz" -P ~/.config/qzsh/
    tar xvf ~/.config/qzsh/todo.txt_cli-2.12.0.tar.gz -C ~/.config/qzsh/todo --strip 1 && rm ~/.config/qzsh/todo.txt_cli-2.12.0.tar.gz
    ln -s -f ~/.config/qzsh/todo/todo.sh ~/.config/qzsh/bin/todo.sh  # Include todo.sh in $PATH
    ln -s -f ~/.config/qzsh/todo/todo.cfg ~/.todo.cfg  # Link todo.cfg
else
    echo -e "todo.sh is already installed in ~/.config/qzsh/todo/bin/\n"
fi

# ========================================
# History Migration
# ========================================

if [ "$cp_hist_flag" = true ]; then
    if [ -f ~/.bash_history ]; then
        echo -e "\nCopying bash_history to zsh_history\n"
        if command -v python &>/dev/null; then
            cat ~/.bash_history | python "$SCRIPT_DIR/bash-to-zsh-hist.py" >> ~/.zsh_history
        else
            if command -v python3 &>/dev/null; then
                cat ~/.bash_history | python3 "$SCRIPT_DIR/bash-to-zsh-hist.py" >> ~/.zsh_history
            else
                echo "Python is not installed, can't copy bash_history to zsh_history\n"
            fi
        fi
    else
        echo -e "\nNo bash_history file found, skipping history migration\n"
    fi
else
    echo -e "\nNot copying bash_history to zsh_history, as --cp-hist or -c is not supplied\n"
fi

# ========================================
# Final Instructions
# ========================================

change_shell() {
    local user=$1
    if [ "$EUID" -eq 0 ]; then
        # Si se está ejecutando como root, cambia el shell del usuario especificado.
        echo -e "\nChanging default shell to zsh for user $user\n"
        chsh -s $(which zsh) "$user"
    else
        # Si no se está ejecutando como root, necesita sudo.
        echo -e "\nSudo access is needed to change default shell\n"
        sudo chsh -s $(which zsh) "$user"
    fi
}

verify_shell_change() {
    local user=$1
    local shell=$(getent passwd "$user" | cut -d: -f7)
    if [ "$shell" == "$(which zsh)" ]; then
        echo -e "\nShell successfully changed to zsh for user $user\n"
    else
        echo -e "\nFailed to change shell for user $user\n"
    fi
}

# Detectar el usuario local no root
get_local_user() {
    # Esto asume que el primer usuario no root en el sistema es el usuario local
    local_user=$(logname 2>/dev/null || who | awk '{print $1}' | sort | uniq | grep -v 'root' | head -n 1)
    echo "$local_user"
}

# Crear .zshrc y qzshrc.zsh si no existen
create_zshrc() {
    local user_home=$(eval echo "~$1")
    cp -f "$SCRIPT_DIR/.zshrc" "$user_home/"
    cp -f "$SCRIPT_DIR/qzshrc.zsh" "$user_home/.config/qzsh/"
    echo -e "\nCopied .zshrc and qzshrc.zsh for user $1\n"
}

if [ "$noninteractive_flag" = true ]; then
    echo -e "Installation complete, exit terminal and enter a new zsh session\n"
    echo -e "Make sure to change zsh to default shell by running: chsh -s $(which zsh)"
    echo -e "In a new zsh session manually run: build-fzf-tab-module"
else
    # Detectar el usuario actual
    current_user=$(whoami)

    # Cambiar el shell del usuario actual
    change_shell "$current_user"
    verify_shell_change "$current_user"
    create_zshrc "$current_user"

    # Detectar el usuario local no root
    local_user=$(get_local_user)
    if [ -n "$local_user" ] && [ "$current_user" == "root" ]; then
        change_shell "$local_user"
        verify_shell_change "$local_user"
        create_zshrc "$local_user"
    fi

    if [ $? -eq 0 ]; then
        echo -e "Installation complete, exit terminal and enter a new zsh session"
        echo -e "In a new zsh session manually run: build-fzf-tab-module"
    else
        echo -e "Something went wrong"
    fi
fi
exit

