help:
	@echo "make <all|atom|fish|git|ruby-version|tmux|vim>"

all:
	@make vim
	@make tmux
	@make xcompose
	@make fish

#atom:
#	ln -s ${PWD}/.atom ${HOME}/

fish:
	@ln -s ${PWD}/.config/fish ${HOME}/.config/

git:
	@cp .gitconfig ${HOME}/

ruby-version:
		@ln -s ${PWD}/.ruby-version ${HOME}/

tmux:
	@ln -s ${PWD}/.tmux.conf ${HOME}/

vim:
	@ln -s ${PWD}/.vim ${HOME}/
	@ln -s ${PWD}/.vimrc ${HOME}/

xcompose:
	@ln -s ${PWD}/.XCompose ${HOME}/
