function vim --description 'An alias that starts tarts emacs instead of vim'

	emacsclient -nc -a "" $argv
end
