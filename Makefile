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


unstow:
	stow --delete --target=${HOME} bash/
	stow --delete --target=${HOME} conda/
	stow --delete --target=${HOME} cookiecutter/
	stow --delete --target=${HOME} git/
	stow --delete --target=${HOME} tmux/
	stow --delete --target=${HOME} vim/
	stow --delete --target=${HOME} wtfutil/
	stow --delete --target=${HOME} nvim/
