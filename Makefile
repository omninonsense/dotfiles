.PHONY: help

help:
	@printf "Got these makaroons "
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$' | xargs

fish:
	-ln -s ${PWD}/.config/fish ${HOME}/.config/

git:
	-cp .gitconfig ${HOME}/

ruby-version:
	-ln -s ${PWD}/.ruby-version ${HOME}/

tmux:
	-ln -s ${PWD}/.tmux.conf ${HOME}/

vim:
	-ln -s ${PWD}/.vim ${HOME}/
	-ln -s ${PWD}/.vimrc ${HOME}/

xcompose:
	-ln -s ${PWD}/.XCompose ${HOME}/

i3:
	-ln -s ${PWD}/.config/i3 ${HOME}/.config/
	-ln -s ${PWD}/.config/polybar ${HOME}/.config/
	-ln -s ${PWD}/.config/dunst ${HOME}/.config/
	-ln -s ${PWD}/.config/rofi ${HOME}/.config/

scripts:
	-mkdir -p ${HOME}/bin
	-ln -s ${PWD}/scripts/fancywrap ${HOME}/bin
	-ln -s ${PWD}/scripts/delay-screensaver ${HOME}/bin
	-ln -s ${PWD}/scripts/git-branch-status ${HOME}/bin
	-ln -s ${PWD}/scripts/i3-exit ${HOME}/bin
	-ln -s ${PWD}/scripts/launch-polybar ${HOME}/bin
	-ln -s ${PWD}/scripts/lock ${HOME}/bin
	-ln -s ${PWD}/scripts/poly-i3-iconlist ${HOME}/bin
	-ln -s ${PWD}/scripts/set-backgrounds ${HOME}/bin
	-ln -s ${PWD}/scripts/snip ${HOME}/bin
	-ln -s ${PWD}/scripts/switch-keyboard-layout ${HOME}/bin
	-ln -s ${PWD}/scripts/googlies ${HOME}/bin
