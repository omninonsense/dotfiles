help:
	@echo "make <all|atom|fish|git|ruby-version|tmux|vim>"

all:
	@make vim
	@make tmux
	@make git
	@make fish

atom:
	ln -s ${PWD}/.atom ${HOME}/

fish:
	@ln -s ${PWD}/.config/fish ${HOME}/.config/

git:
	@cp .gitconfig ${HOME}/.gitconfig

ruby-version:
		@ln -s ${PWD}/.ruby-version ${HOME}/.ruby-version

tmux:
	@ln -s ${PWD}/.tmux.conf ${HOME}/.tmux.conf

vim:
	@ln -s ${PWD}/.vim ${HOME}/
	@ln -s ${PWD}/.vimrc ${HOME}/.vimrc
