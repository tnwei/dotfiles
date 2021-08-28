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

# 3. Unstow from repo dir 
stow -D tmux
stow -D vim
...
```

+ `git` requires adding include to `.gitmyconfig` in `~/.gitconfig`

## Fonts

+ UI: Overpass
+ Serif: Crimson Text
+ Sans Serif: Open Sans
+ Monospace: Fira Mono, Source Code Pro
+ Ebooks: Literata Light, Crimson Text

Follow [this article](https://medium.com/source-words/how-to-manually-install-update-and-uninstall-fonts-on-linux-a8d09a3853b0) on font intsallation on Linux
