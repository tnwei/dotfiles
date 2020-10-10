# Tried regexing to automatically link each file in the repo
# Not worth the time required to figure out an elegant solution
# 
# Methods that glob dotfiles give me the path w/ them
# Need to be able to do that w/o the path in front

.PHONY: dots clean

dots: 
	ln -vfs ${PWD}/.tmux.conf ${HOME}/.tmux.conf
	ln -vfs ${PWD}/.vimrc ${HOME}/.vimrc

clean :
	unlink ${HOME}/.tmux.conf
	unlink ${HOME}/.vimrc
