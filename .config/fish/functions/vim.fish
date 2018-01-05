function vim --description 'An alias that starts emacs instead of vim'
  emacsclient -n -a "" $argv
end
