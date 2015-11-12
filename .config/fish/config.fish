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
set -g fish_color_comment              black              # the color used for code comments

set -g fish_color_match                normal             # the color used to highlight matching parenthesis
set -g fish_color_autosuggestion       white              # the color used for suggestions

set -g fish_color_operator             blue               # the color for parameter expansion operators like '*' and '~'
set -g fish_color_cwd                  green              # the color used for the current working directory in the default prompt

set -g fish_pager_color_prefix         yellow --bold      # the color of the prefix string i.e. the string that is to be completed
set -g fish_pager_color_completion     normal             # the color of the completion itself
set -g fish_pager_color_description    black              # the color of the completion description
set -g fish_color_search_match         --background=black # the color used to highlight history search matches

# Enable Chruby
# source /usr/local/share/chruby/chruby.fish
# source /usr/local/share/chruby/auto.fish

# Include secrets
source ~/.config/fish/secrets/*.fish

# Add $HOME/bin to $PATH
set -gx PATH $HOME/bin $PATH

# Add Ruby to path
set -gx PATH $HOME/.gem/ruby/2.2.0/bin $PATH

# Set vim as editor
set -gx EDITOR vim
set -gx VISUAL $EDITOR

# Set appropriate term
if [ "$TERM" != "screen-256color" ]
  set -gx TERM xterm-256color
end
