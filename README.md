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
  - [k](https://github.com/supercrabtree/k)
  - [marker](https://github.com/pindexis/marker)
  - [todotxt](https://github.com/todotxt/todo.txt-cli)

## Demo
Your command prompt will look like this (easily customizable):
![prompt](https://user-images.githubusercontent.com/8462091/43674765-8bb13a76-9817-11e8-8b7b-16b8b1998408.png)
![image](https://github.com/dioni-dev/QuickZSH/assets/58851263/29ef0753-7ef7-4f6b-867f-5a51711768be)

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

This will install the setup under ~/.config/QuickZSH/. Change your terminal's fonts to either "RobotoMono Nerd Font", "Hack Nerd Font", or "DejaVu Sans Mono Nerd Fonts". You can also manually install Nerd Fonts of your choice.


## Configuration
### Default Aliases and Plugins
The setup includes the following useful aliases and Oh My Zsh plugins. You can add more or overwrite these in your personal zsh config files under `~/.config/QuickZSH/zshrc/`.

- `l="ls -lah"`: Short command for `ls -lah`.
- `e="exit"`: Exit terminal.
- `x="extract"`: Extract any compressed files.
- `z`: Quickly jump to most visited directories.
- `web-search`: Search on the web from CLI.
- `sudo`: Easily prefix your commands with sudo by pressing `esc` twice.
- `systemd`: Useful aliases for systemd.
- `https`: Make httpie use https.
- `myip`: Quickly find out external IP.
- `cheat`: Cheatsheets in the terminal.
- `speedtest`: Run speedtest on the fly.
- `dict`: Dictionary definitions.
- `ipgeo`: Finds geo location from IP.

### Customization
- Place your configurations in `~/.config/QuickZSH/zshrc/` to override the default settings.
- Customize the Powerlevel10k settings by editing your personal config file under `~/.config/QuickZSH/zshrc/`.

## Notes
- Use any terminal besides QTerminal (default in Kali-Xfce). Recommended: `xfce4-terminal` for Kali.
- If already using zsh, your config will be backed up to `.zshrc-backup-date`.
- If text/icons look broken, ensure your terminal uses Nerd fonts. Recommended: "RobotoMono Nerd Font".
- `marker` shortcut "Ctrl+t" clashes with fzf, rebound to "Ctrl+b".
- All Oh My Zsh plugins are installed under `~/.config/QuickZSH/oh-my-zsh/plugin`.
- Other tools (fzf, marker, todo) are installed in `~/.config/QuickZSH/`.
- `zsh-autosuggestions` is not enabled due to conflict with Marker. Enable it by adding `plugins+=(zsh-autosuggestions)` to your personal config file if not using Marker.


## Uninstallation
To uninstall, simply delete `~/.zshrc` and `~/.config/QuickZSH/`. Restore your original `.zshrc` from the backup created in your home folder.

## Contributing
Suggestions for cool tools are always welcome! Feel free to open an issue or submit a pull request.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact
For support or inquiries, please open an issue on the [GitHub repository](https://github.com/dioni-dev/QuickZSH).
