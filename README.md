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


