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
    echo -e "ZSH, Git, and Wget are already installed\n"
else
    # Try to install dependencies using various package managers
    if sudo apt install -y zsh git wget autoconf || sudo pacman -S zsh git wget || sudo dnf install -y zsh git wget || sudo yum install -y zsh git wget || sudo brew install git zsh wget || pkg install git zsh wget ; then
        echo -e "zsh, wget, and git Installed\n"
    else
        echo -e "Please install the following packages first, then try again: zsh git wget\n" && exit
    fi
fi

# ========================================
# Backup Existing .zshrc
# ========================================

# Backup the current .zshrc if it exists
backup_zshrc() {
    local user_home=$(eval echo "~$1")
    if [ -f "$user_home/.zshrc" ]; then
        mv "$user_home/.zshrc" "$user_home/.zshrc-backup-$(date +"%Y-%m-%d")"
        echo -e "Backed up the current .zshrc for user $1\n"
    fi
}

# ========================================
# Install Oh My Zsh
# ========================================

install_oh_my_zsh() {
    local user_home=$(eval echo "~$1")
    local zsh_dir="$user_home/.config/qzsh/oh-my-zsh"
    mkdir -p "$zsh_dir"
    if [ -d "$zsh_dir" ]; then
        echo -e "Installing oh-my-zsh for user $1\n"
        git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$zsh_dir"
    fi
}

# ========================================
# Copy Configuration Files
# ========================================

copy_config_files() {
    local user_home=$(eval echo "~$1")
    cp -f "$SCRIPT_DIR/.zshrc" "$user_home/"
    mkdir -p "$user_home/.config/qzsh"
    cp -f "$SCRIPT_DIR/qzshrc.zsh" "$user_home/.config/qzsh/"
    echo -e "\nCopied .zshrc and qzshrc.zsh for user $1\n"
}

# ========================================
# Setup Directories for Configurations and Cache
# ========================================

setup_directories() {
    local user_home=$(eval echo "~$1")
    mkdir -p "$user_home/.config/qzsh/zshrc"
    mkdir -p "$user_home/.cache/zsh/"
    mkdir -p "$user_home/.fonts"
    echo -e "Directories setup for user $1\n"
}

# ========================================
# Install Plugins
# ========================================

install_plugins() {
    local user_home=$(eval echo "~$1")
    local zsh_dir="$user_home/.config/qzsh/oh-my-zsh"
    install_or_update_repo https://github.com/zsh-users/zsh-autosuggestions "$zsh_dir/plugins/zsh-autosuggestions"
    install_or_update_repo https://github.com/zsh-users/zsh-syntax-highlighting.git "$zsh_dir/custom/plugins/zsh-syntax-highlighting"
    install_or_update_repo https://github.com/zsh-users/zsh-completions "$zsh_dir/custom/plugins/zsh-completions"
    install_or_update_repo https://github.com/zsh-users/zsh-history-substring-search "$zsh_dir/custom/plugins/zsh-history-substring-search"
    install_or_update_repo https://github.com/romkatv/powerlevel10k.git "$zsh_dir/custom/themes/powerlevel10k"
    install_or_update_repo https://github.com/junegunn/fzf.git "$user_home/.config/qzsh/fzf"
    "$user_home/.config/qzsh/fzf/install" --all --key-bindings --completion --no-update-rc
    install_or_update_repo https://github.com/Aloxaf/fzf-tab "$zsh_dir/custom/plugins/fzf-tab"
    install_or_update_repo https://github.com/jotyGill/marker "$user_home/.config/qzsh/marker"
    if "$user_home/.config/qzsh/marker/install.py"; then
        echo -e "Installed Marker for user $1\n"
    else
        echo -e "Marker Installation Had Issues for user $1\n"
    fi
}

# Function to install or update a git repository
install_or_update_repo() {
    local repo_url=$1
    local target_dir=$2

    if [ -d "$target_dir" ]; then
        cd "$target_dir" && git pull
    else
        git clone --depth=1 "$repo_url" "$target_dir"
    fi
}

# ========================================
# Install Fonts
# ========================================

install_fonts() {
    local user_home=$(eval echo "~$1")
    wget -q --show-progress -N https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/HackNerdFont-Regular.ttf -P "$user_home/.fonts/"
    wget -q --show-progress -N https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/RobotoMono/Regular/RobotoMonoNerdFont-Regular.ttf -P "$user_home/.fonts/"
    wget -q --show-progress -N https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DejaVuSansMono/Regular/DejaVuSansMNerdFont-Regular.ttf -P "$user_home/.fonts/"
    fc-cache -fv "$user_home/.fonts"
    echo -e "Installed Nerd Fonts for user $1\n"
}

# ========================================
# Install todo.txt-cli
# ========================================

install_todo_cli() {
    local user_home=$(eval echo "~$1")
    if [ ! -L "$user_home/.config/qzsh/todo/bin/todo.sh" ]; then
        echo -e "Installing todo.sh in ~/.config/qzsh/todo for user $1\n"
        mkdir -p "$user_home/.config/qzsh/bin"
        mkdir -p "$user_home/.config/qzsh/todo"
        wget -q --show-progress "https://github.com/todotxt/todo.txt-cli/releases/download/v2.12.0/todo.txt_cli-2.12.0.tar.gz" -P "$user_home/.config/qzsh/"
        tar xvf "$user_home/.config/qzsh/todo.txt_cli-2.12.0.tar.gz" -C "$user_home/.config/qzsh/todo" --strip 1 && rm "$user_home/.config/qzsh/todo.txt_cli-2.12.0.tar.gz"
        ln -s -f "$user_home/.config/qzsh/todo/todo.sh" "$user_home/.config/qzsh/bin/todo.sh"
        ln -s -f "$user_home/.config/qzsh/todo/todo.cfg" "$user_home/.todo.cfg"
    else
        echo -e "todo.sh is already installed in ~/.config/qzsh/todo/bin/ for user $1\n"
    fi
}

# ========================================
# History Migration
# ========================================

migrate_history() {
    local user_home=$(eval echo "~$1")
    if [ "$cp_hist_flag" = true ]; then
        if [ -f "$user_home/.bash_history" ]; then
            echo -e "\nCopying bash_history to zsh_history for user $1\n"
            if command -v python &>/dev/null; then
                cat "$user_home/.bash_history" | python "$SCRIPT_DIR/bash-to-zsh-hist.py" >> "$user_home/.zsh_history"
            else
                if command -v python3 &>/dev/null; then
                    cat "$user_home/.bash_history" | python3 "$SCRIPT_DIR/bash-to-zsh-hist.py" >> "$user_home/.zsh_history"
                else
                    echo "Python is not installed, can't copy bash_history to zsh_history for user $1\n"
                fi
            fi
        else
            echo -e "\nNo bash_history file found, skipping history migration for user $1\n"
        fi
    else
        echo -e "\nNot copying bash_history to zsh_history, as --cp-hist or -c is not supplied for user $1\n"
    fi
}

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
    mkdir -p "$user_home/.config/qzsh"
    cp -f "$SCRIPT_DIR/.zshrc" "$user_home/"
    cp -f "$SCRIPT_DIR/qzshrc.zsh" "$user_home/.config/qzsh/"
    echo -e "\nCopied .zshrc and qzshrc.zsh for user $1\n"
}

if [ "$noninteractive_flag" = true ]; then
    echo -e "Installation complete, exit terminal and enter a new zsh session\n"
    echo -e "Make sure to change zsh to default shell by running: chsh -s $(which zsh)"
    echo -e "In a new zsh session manually run: build-fzf-tab-module"
else
    # Obtén el directorio del script actual
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    # Detectar el usuario actual
    current_user=$(whoami)

    # Cambiar el shell del usuario actual
    change_shell "$current_user"
    verify_shell_change "$current_user"
    backup_zshrc "$current_user"
    install_oh_my_zsh "$current_user"
    copy_config_files "$current_user"
    setup_directories "$current_user"
    install_plugins "$current_user"
    install_fonts "$current_user"
    install_todo_cli "$current_user"
    migrate_history "$current_user"

    # Detectar el usuario local no root
    local_user=$(get_local_user)
    if [ -n "$local_user" ] && [ "$current_user" == "root" ]; then
        change_shell "$local_user"
        verify_shell_change "$local_user"
        backup_zshrc "$local_user"
        install_oh_my_zsh "$local_user"
        copy_config_files "$local_user"
        setup_directories "$local_user"
        install_plugins "$local_user"
        install_fonts "$local_user"
        install_todo_cli "$local_user"
        migrate_history "$local_user"
    fi

    if [ $? -eq 0 ]; then
        echo -e "Installation complete, exit terminal and enter a new zsh session"
        echo -e "In a new zsh session manually run: build-fzf-tab-module"
    else
        echo -e "Something went wrong"
    fi
fi
exit

