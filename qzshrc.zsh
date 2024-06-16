# ========================================
# Terminal and Environment Configuration
# ========================================

# Set terminal type to support 256 colors
export TERM="xterm-256color"

# If you come from bash you might have to change your $PATH.
# Uncomment and modify the following line if needed:
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation
export ZSH=$HOME/.config/qzsh/oh-my-zsh

# Add to PATH to install and run programs with "pip install --user"
export PATH=$PATH:~/.local/bin

# Add qzsh bin directory to PATH
export PATH=$PATH:~/.config/qzsh/bin

# Set npm packages directory and add to PATH
NPM_PACKAGES="${HOME}/.npm"
export PATH="$NPM_PACKAGES/bin:$PATH"

# Source marker if it exists
[[ -s "$HOME/.config/qzsh/marker/marker.sh" ]] && source "$HOME/.config/qzsh/marker/marker.sh"

# Initialize zsh completions
autoload -U compinit && compinit -C -d ~/.cache/zsh/.zcompdump

# Uncomment the following lines to enable bash completions
# autoload bashcompinit
# bashcompinit

# ========================================
# Powerlevel10k Theme Configuration
# ========================================

# Set Powerlevel10k mode to use Nerd Fonts
POWERLEVEL9K_MODE='nerdfont-complete'

# Set the theme to Powerlevel10k
ZSH_THEME="powerlevel10k/powerlevel10k"

# Customize Powerlevel10k theme appearance
POWERLEVEL9K_OS_ICON_BACKGROUND="white"
POWERLEVEL9K_OS_ICON_FOREGROUND="blue"
POWERLEVEL9K_DIR_HOME_FOREGROUND="white"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="white"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="white"

# Define elements for the right side of the prompt
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    status
    command_execution_time
    background_jobs
    ram
    load
    rvm
    time
)

# Define elements for the left side of the prompt
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    ssh
    os_icon
    context
    dir
    vcs
)

# Enable prompt on a new line
POWERLEVEL9K_PROMPT_ON_NEWLINE=true

# ========================================
# Oh My Zsh Plugin Configuration
# ========================================

# List of plugins to load
plugins=(
    zsh-completions
    # zsh-autosuggestions     # disable when using marker, otherwise enable
    zsh-syntax-highlighting
    history-substring-search
    screen
    systemd
    web-search
    extract
    z
    sudo
    # k
    # httpie
    # git
    # python
    # docker
    # lol
    # pip
    # pyenv
    # redis-cli
    # zsh-wakatime          # enable if you use wakatime with 'https://github.com/wbingli/zsh-wakatime'
)

# ========================================
# User Configuration
# ========================================

# Uncomment and set the MANPATH if needed
# export MANPATH="/usr/local/man:$MANPATH"

# Manually set your language environment if needed
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# Uncomment and set your preferred editor
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# SSH key path
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Save up to 50,000 lines in history. Oh-my-zsh default is 10,000
SAVEHIST=50000
#setopt hist_ignore_all_dups  # Don't record duplicated entries in history during a single session

# ========================================
# Optional Configurations
# ========================================

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Specify another custom folder than $ZSH/custom if desired
# ZSH_CUSTOM=/path/to/new-custom-folder

# ========================================
# Aliases
# ========================================

alias myip="wget -qO- https://wtfismyip.com/text"  # Quickly show external IP address
alias l="ls --hyperlink=auto -lAhrtF"  # Show all except . .. , sort by recent, / at the end of folders, clickable
alias e="exit"  # Exit terminal
alias ip="ip --color=auto"  # Use colored output for ip command
alias update='sudo apt update && sudo apt upgrade -y'  # Update system
alias clean='sudo apt autoremove && sudo apt autoclean'  # Clean system
alias c='clear'  # Clear terminal

# ========================================
# Custom Functions
# ========================================

# Function to fetch cheat sheets (github.com/chubin/cheat.sh)
# Example usage: 'cheat tar'
# For language-specific questions supply 2 args: first for language, second as the question
# Example: cheat python3 execute external program
cheat() {
    if [ "$2" ]; then
        curl "https://cheat.sh/$1/$2+$3+$4+$5+$6+$7+$8+$9+$10"
    else
        curl "https://cheat.sh/$1"
    fi
}

# Matrix screen saver! Will run if you have installed "cmatrix"
# Uncomment the following lines to enable
# TMOUT=900
# TRAPALRM() { if command -v cmatrix &> /dev/null; then cmatrix -sb; fi }

# Function to perform speed tests
speedtest() {
    curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -
}

# Function to find dictionary definitions
dict() {
    if [ "$3" ]; then
        curl "dict://dict.org/d:$1 $2 $3"
    elif [ "$2" ]; then
        curl "dict://dict.org/d:$1 $2"
    else
        curl "dict://dict.org/d:$1"
    fi
}

# Function to find geo information from IP
ipgeo() {
    # Specify IP or your own IP will be used
    if [ "$1" ]; then
        curl "http://api.db-ip.com/v2/free/$1"
    else
        curl "http://api.db-ip.com/v2/free/$(myip)"
    fi
}

# Function to extract various compressed file formats
extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)  tar xjf $1     ;;  # Extract .tar.bz2 files
            *.tar.gz)   tar xzf $1     ;;  # Extract .tar.gz files
            *.bz2)      bunzip2 $1     ;;  # Extract .bz2 files
            *.rar)      unrar e $1     ;;  # Extract .rar files
            *.gz)       gunzip $1      ;;  # Extract .gz files
            *.tar)      tar xf $1      ;;  # Extract .tar files
            *.tbz2)     tar xjf $1     ;;  # Extract .tbz2 files
            *.tgz)      tar xzf $1     ;;  # Extract .tgz files
            *.zip)      unzip $1       ;;  # Extract .zip files
            *.Z)        uncompress $1  ;;  # Extract .Z files
            *.7z)       7z x $1        ;;  # Extract .7z files
            *)          echo "'$1' cannot be extracted via extract()" ;;  # Handle unknown file types
        esac
    else
        echo "'$1' is not a valid file"  # Error message for invalid file
    fi
}

# Function to create a directory and change to it
mkcd() {
    mkdir -p "$1"  # Create directory if it doesn't exist
    cd "$1"  # Change to the created directory
}

# Function to display PATH variable in a readable format
path() {
    echo -e ${PATH//:/\\n}  # Replace colons with newlines for readability
}

# Function to get local IP addresses
iplocal() {
    ip addr show | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | cut -f1 -d'/'  # Extract local IPs excluding localhost
}
