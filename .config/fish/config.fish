# Include secrets
for file in ~/.config/fish/secrets/*.fish
  source $file
end

# Machine-specific stuff
for file in ~/.config/machines/(hostname).d/*.fish
  source $file
end

# This one is only required at work machine. So making it silent for now.
add_to_path --silent "/usr/local/go/bin"
add_to_path "$HOME/go/bin/"
add_to_path "$HOME/.dotnet/"
add_to_path "$HOME/.cabal/bin"
add_to_path "$HOME/.cargo/bin"
add_to_path "$HOME/bin"
add_to_path "$HOME/.local/bin"

# Set vim as editor
set -gx EDITOR vim
set -gx VISUAL $EDITOR

# Set appropriate term
if [ "$TERM" != "screen-256color" ]
  set -gx TERM xterm-256color
end

abbr -a g git

if status --is-interactive
  if test -f "source ~/.local/share/icons-in-terminal/icons.fish"
    source ~/.local/share/icons-in-terminal/icons.fish 
  end

  setfont /usr/share/kbd/consolefonts/Lat2-Terminus16 ^/dev/null
  starship init fish | source
end


