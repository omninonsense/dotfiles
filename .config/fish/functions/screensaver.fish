function screensaver -d "Terminal Screensaver"
  tmux new "tmux set status off; bash $HOME/dotfiles/screensaver.sh; tmux set status on"
end
