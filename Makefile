# Tried regexing to automatically link each file in the repo
# Not worth the time required to figure out an elegant solution
# 
# Methods that glob dotfiles give me the path w/ them
# Need to be able to do that w/o the path in front

.PHONY: dots clean

dots: 
	ln -vfs ${PWD}/.tmux.conf ${HOME}/.tmux.conf
	ln -vfs ${PWD}/.vimrc ${HOME}/.vimrc
	
# Test if exists, then only unlink 
# Note: && doesn't run 2nd part if 1st part fails
# Note: ":" is basically like Python's "pass"
# Handles the myriad of things that happens to files between makes
clean :
	test -f ${HOME}/.tmux.conf && unlink ${HOME}/.tmux.conf || :
	test -f ${HOME}/.vimrc && unlink ${HOME}/.vimrc || :
