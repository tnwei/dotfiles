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

## micromamba

At time of writing, it is not declared production-ready yet and is meant for use in CI. No issues daily driving it tho.

``` bash
wget -qO- https://micromamba.snakepit.net/api/micromamba/linux-64/latest | tar -xvj bin/micromamba
mv bin/micromamba ~/.local/bin/micromamba
chmod +x ~/.local/bin/micromamba
./local/bin/micromamba shell init -s bash -p ~/micromamba
```

## wtfutil

Just running `wtfutil` should work since the default file name is used, similar to running `wtfutil -c=~/.config/wtf/config.yml`.

## Other tools

For reference when setting up a new system:

ranger, htop, neofetch, miniconda3, vim, zathura, regolith linux stack (easy way to have i3-gaps, dwm, drun), pywal, tldr, dtrx (only up to Ubuntu 18), heroku CLI, ripgrep, fzf
