# My dotfiles

Storing my dotfiles in this repo to sync them across machines. Uses GNU `stow` to manage symlinking. 

```
# 1. Clone to homedir
cd ~
git clone git@github.com:tnwei/dotfiles.git

# 1b. (Optional) Hide dotfiles folder
mv dotfiles .dotfiles

# 2. Symlink dots by running `stow` on folders from within cloned dir 
cd dotfiles # OR `cd .dotfiles`
stow tmux
stow vim
...

# 2b. Or use stow.sh to loop
bash stow.sh

# 3. Unstow from repo dir 
stow -D tmux
stow -D vim
...

# 3b. Or use unstow.sh to loop
bash unstow.sh
```

+ `git` requires adding include to `.gitmyconfig` in `~/.gitconfig`

## Fonts

+ UI: Overpass
+ Serif: Crimson Text
+ Sans Serif: Open Sans
+ Monospace: Fira Mono, Source Code Pro
+ Ebooks: Literata Light, Crimson Text

Follow [this article](https://medium.com/source-words/how-to-manually-install-update-and-uninstall-fonts-on-linux-a8d09a3853b0) on font intsallation on Linux

## Pipx tools

+ `pipx install black`
+ `pipx install cookiecutter`
+ `pipx install dvc[all]`
+ `pipx install mkdocs mkdocs-material`
+ `pipx install jupyter-book`
+ `pipx install nbdime`
+ `pipx install pre-commit`

## Other tools

For reference when setting up a new system:

ranger, htop, neofetch, miniconda3, vim, zathura, regolith linux stack (easy way to have i3-gaps, dwm, drun), pywal, tldr, dtrx (only up to Ubuntu 18), heroku CLI
