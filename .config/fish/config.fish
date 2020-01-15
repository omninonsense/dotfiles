set -g gnome_profile_bg                272B33             # Default background color of the terminal emulator
set -g gnome_profile_fg                AAB1BF             # Default foreground color. This equals `normal` color.

set -g fish_color_normal               normal             # the default color

set -g fish_color_command              blue               # the color for commands
set -g fish_color_param                normal             # the color for regular command parameters

set -g fish_color_quote                green              # the color for quoted blocks of text
set -g fish_color_escape               cyan               # the color used to highlight character escapes like '\n' and '\x70'

set -g fish_color_redirection          purple             # the color for IO redirections
set -g fish_color_end                  purple             # the color for process separators like ';' and '&'

set -g fish_color_error                red --underline    # the color used to highlight potential errors
set -g fish_color_comment              555                # the color used for code comments

set -g fish_color_match                normal             # the color used to highlight matching parenthesis
set -g fish_color_autosuggestion       567                # the color used for suggestions

set -g fish_color_operator             blue               # the color for parameter expansion operators like '*' and '~'
set -g fish_color_cwd                  green              # the color used for the current working directory in the default prompt

set -g fish_pager_color_prefix         yellow --bold      # the color of the prefix string i.e. the string that is to be completed
set -g fish_pager_color_completion     normal             # the color of the completion itself
set -g fish_pager_color_description    black              # the color of the completion description
set -g fish_color_search_match         --background=black # the color used to highlight history search matches

# Enable Chruby
if test -e /usr/local/share/chruby/chruby.fish
    source /usr/local/share/chruby/chruby.fish
end

if test -e /usr/local/share/chruby/auto.fish
    source /usr/local/share/chruby/auto.fish
end

# Include secrets
source ~/.config/fish/secrets/*.fish

# Include some work-specific stuff
if test -f ~/.config/fish/work.fish
  source ~/.config/fish/work.fish
end

if test -f ~/.config/fish/home.fish
  source ~/.config/fish/home.fish
end

# Add $HOME/bin to $PATH
set -gx PATH $HOME/bin $PATH

# Add Hackage/Cabal to BIN
if test -d $HOME/.cabal/bin
  set -gx PATH $HOME/bin $PATH
end

# Add Ruby gems to path
set -gx PATH $HOME/.gem/ruby/(ruby -r 'rbconfig' -e 'puts RbConfig::CONFIG["ruby_version"]')/bin $PATH

# Set vim as editor
set -gx EDITOR vim
set -gx VISUAL $EDITOR

# Set appropriate term
if [ "$TERM" != "screen-256color" ]
  set -gx TERM xterm-256color
end


if status --is-interactive
  source ~/.local/share/icons-in-terminal/icons.fish
  setfont /usr/share/kbd/consolefonts/Lat2-Terminus16 ^/dev/null
  starship init fish | source
end

if test -x (which pyenv)
  pyenv init - | source
end

if test -f $HOME/.poetry/env
  source $HOME/.poetry/env
end

if test -d $HOME/.dotnet/
  set -gx PATH $HOME/.dotnet $PATH
end


if test -d $HOME/.cargo/bin
  set -gx PATH $HOME/.cargo/bin $PATH
end
