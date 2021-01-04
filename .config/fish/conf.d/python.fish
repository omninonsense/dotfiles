if type -q pyenv
  pyenv init - | source
end

if test -f $HOME/.poetry/env
  source $HOME/.poetry/env
end
