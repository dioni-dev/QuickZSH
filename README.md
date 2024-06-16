# QuickZSH - A Simple Script to Setup an Awesome Shell Environment

## Overview
`QuickZSH` is a script designed to quickly install and configure `zsh` and `oh-my-zsh` with a powerful and aesthetically pleasing shell environment. It includes themes, fonts, and plugins to enhance your terminal experience.

### Features
- **Theme**: [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- **Fonts**: [Nerd-Fonts](https://github.com/ryanoasis/nerd-fonts)
- **Plugins**:
  - [zsh-completions](https://github.com/zsh-users/zsh-completions)
  - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
  - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
  - [history-substring-search](https://github.com/zsh-users/zsh-history-substring-search)
  - [fzf](https://github.com/junegunn/fzf)
  - [marker](https://github.com/jotyGill/marker)
  - [todo.txt-cli](https://github.com/todotxt/todo.txt-cli)
  - [fzf-tab](https://github.com/Aloxaf/fzf-tab)
  - [powerlevel10k](https://github.com/romkatv/powerlevel10k)

## Demo
Your command prompt will look like this (easily customizable):
![image](https://github.com/dioni-dev/QuickZSH/assets/58851263/bbf1866e-f237-47b9-b7c0-4915d9320248)

- User : Directory : Git stats : Last command exit code : Free memory : Load : Time


## Installation
### Requirements
- `git` to clone the repository.
- `python3` or `python` is required to run the option '-c' which copies history from .bash_history.

### Steps
```bash
git clone https://github.com/dioni-dev/QuickZSH
cd QuickZSH
./install.sh -c  # only run with '-c' the first time, running multiple times will duplicate history entries
```

This will install the setup under `~/.config/qzsh/`. Change your terminal's fonts to either "RobotoMono Nerd Font", "Hack Nerd Font", or "DejaVu Sans Mono Nerd Fonts". You can also manually install Nerd Fonts of your choice.

## Configuration
### Default Aliases and Plugins
The setup includes the following useful aliases and Oh My Zsh plugins. You can add more or overwrite these in your personal zsh config files under `~/.config/qzsh/zshrc/`.

#### Aliases:
- `l="ls --hyperlink=auto -lAhrtF"`: Show all except . .. , sort by recent, / at the end of folders, clickable.
- `e="exit"`: Exit terminal.
- `myip="wget -qO- https://wtfismyip.com/text"`: Quickly show external IP address.
- `ip="ip --color=auto"`: Use colored output for ip command.
- `update='sudo apt update && sudo apt upgrade -y'`: Update system.
- `clean='sudo apt autoremove && sudo apt autoclean'`: Clean system.
- `c='clear'`: Clear terminal.

#### Plugins:
- `zsh-completions`
- `zsh-autosuggestions`
- `zsh-syntax-highlighting`
- `history-substring-search`
- `screen`
- `systemd`
- `web-search`
- `extract`
- `z`
- `sudo`
- `fzf-tab`
- `marker`

### Custom Functions
- **cheat**: Fetch cheat sheets.
    ```zsh
    cheat() {
        if [ "$2" ]; then
            curl "https://cheat.sh/$1/$2+$3+$4+$5+$6+$7+$8+$9+$10"
        else
            curl "https://cheat.sh/$1"
        fi
    }
    ```
- **speedtest**: Perform speed tests.
    ```zsh
    speedtest() {
        curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -
    }
    ```
- **dict**: Find dictionary definitions.
    ```zsh
    dict() {
        if [ "$3" ]; then
            curl "dict://dict.org/d:$1 $2 $3"
        elif [ "$2" ]; then
            curl "dict://dict.org/d:$1 $2"
        else
            curl "dict://dict.org/d:$1"
        fi
    }
    ```
- **ipgeo**: Find geo information from IP.
    ```zsh
    ipgeo() {
        # Specify IP or your own IP will be used
        if [ "$1" ]; then
            curl "http://api.db-ip.com/v2/free/$1"
        else
            curl "http://api.db-ip.com/v2/free/$(myip)"
        fi
    }
    ```
- **extract**: Extract various compressed file formats.
    ```zsh
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
    ```
- **mkcd**: Create a directory and change to it.
    ```zsh
    mkcd() {
        mkdir -p "$1"  # Create directory if it doesn't exist
        cd "$1"  # Change to the created directory
    }
    ```
- **path**: Display PATH variable in a readable format.
    ```zsh
    path() {
        echo -e ${PATH//:/\\n}  # Replace colons with newlines for readability
    }
    ```
- **iplocal**: Get local IP addresses.
    ```zsh
    iplocal() {
        ip addr show | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | cut -f1 -d'/'  # Extract local IPs excluding localhost
    }
    ```

## Customization
- Place your configurations in `~/.config/qzsh/zshrc/` to override the default settings.
- Customize the Powerlevel10k settings by editing your personal config file under `~/.config/qzsh/zshrc/`.

## Notes
- Use any terminal besides QTerminal (default in Kali-Xfce). Recommended: `xfce4-terminal` for Kali.
- If already using zsh, your config will be backed up to `.zshrc-backup-date`.
- If text/icons look broken, ensure your terminal uses Nerd fonts. Recommended: "RobotoMono Nerd Font".
- `marker` shortcut "Ctrl+t" clashes with fzf, rebound to "Ctrl+b".
- All Oh My Zsh plugins are installed under `~/.config/qzsh/oh-my-zsh/plugin`.
- Other tools (fzf, marker, todo) are installed in `~/.config/qzsh/`.
- `zsh-autosuggestions` is not enabled due to conflict with Marker. Enable it by adding `plugins+=(zsh-autosuggestions)` to your personal config file if not using Marker.

## Uninstallation
To uninstall, simply delete `~/.zshrc` and `~/.config/qzsh/`. Restore your original `.zshrc` from the backup created in your home folder.

## Contributing
Suggestions for cool tools are always welcome! Feel free to open an issue or submit a pull request.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact
For support or inquiries, please open an issue on the [GitHub repository](https://github.com/dioni-dev/QuickZSH).
