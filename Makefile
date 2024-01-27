.PHONY: stow unstow

stow:
	stow --target=${HOME} bash/
	stow --target=${HOME} conda/
	stow --target=${HOME} cookiecutter/
	stow --target=${HOME} git/
	stow --target=${HOME} tmux/
	stow --target=${HOME} vim/
	stow --target=${HOME} wtfutil/
	stow --target=${HOME} nvim/
	stow --target=${HOME} hyprland/
	stow --target=${HOME} foot/
	stow --target=${HOME} waybar/
	stow --target=${HOME} wlogout/
	stow --target=${HOME} wofi/
	stow --target=${HOME} dunst/
	# For scripts, the whole folder is added to PATH
	# Symlinking need -r to resolve relative paths
	ln -rs scripts ${HOME}/.local/scripts
	stow --target=${HOME}/.local/share/applications desktop/
	stow --taget=${HOME} rofi/
	stow --taget=${HOME} regolith/

unstow:
	stow --delete --target=${HOME} bash/
	stow --delete --target=${HOME} conda/
	stow --delete --target=${HOME} cookiecutter/
	stow --delete --target=${HOME} git/
	stow --delete --target=${HOME} tmux/
	stow --delete --target=${HOME} vim/
	stow --delete --target=${HOME} wtfutil/
	stow --delete --target=${HOME} nvim/
	stow --delete --target=${HOME} hyprland/
	stow --delete --target=${HOME} foot/
	stow --delete --target=${HOME} waybar/
	stow --delete --target=${HOME} wlogout/
	stow --delete --target=${HOME} wofi/
	stow --delete --target=${HOME} dunst/
	unlink ${HOME}/.local/scripts
	stow --delete --target=${HOME}/.local/share/applications desktop/
	stow --delete --target=${HOME} rofi/
	stow --delete --target=${HOME} regolith/