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

function add_to_path --description "Add a directory to the path if it exists."
  set atp_debug false
  set atp_warn true

  argparse --name add_to_path --exclusive 'silent,debug' 'h/help' 's/silent' 'd/debug' -- $argv
  or return 1

  if set -q _flag_help
    set fn_info (functions -v --details add_to_path)

    echo "add_to_path - $fn_info[5]"
    echo " "
    echo (set_color brwhite)"  -h --help   "(set_color normal)" - Prints this message"
    echo (set_color brwhite)"  -s --silent "(set_color normal)" - Don't print any warnings or debug messages"
    echo (set_color brwhite)"  -d --debug "(set_color normal)" - Print debugging information"
    return 0
  end

  if set -q _flag_silent
    set atp_warn false
  end

  if set -q _flag_debug
    set atp_debug true
  end

  set -l location $argv[1]

  set -l atp_debug_prefix "["(set_color brblue)"add_to_path:debug"(set_color normal)"]"
  set -l atp_warn_prefix "["(set_color bryellow)"add_to_path:warn"(set_color normal)" ]"

  if test -d $location
    $atp_debug && echo $atp_debug_prefix (set_color -u blue)$location(set_color normal)" added to PATH"(set_color normal)
    set -gx PATH "$location" $PATH
  else
    $atp_debug || $atp_warn && echo $atp_warn_prefix (set_color red)$location(set_color normal)" isn't a directory"(set_color normal)
  end
end

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

set RUBY_VERSION (ruby -e "puts RUBY_VERSION")

# This one is only required at work machine. So making it silent for now.
add_to_path --silent "/usr/local/go/bin"
add_to_path "$HOME/go/bin/"
add_to_path "$HOME/.dotnet/"
add_to_path "$HOME/.gem/ruby/$RUBY_VERSION/bin"
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

# Add common abbreviations
abbr -a be bundle exec
abbr -a g git

if status --is-interactive
  if test -f "source ~/.local/share/icons-in-terminal/icons.fish"
    source ~/.local/share/icons-in-terminal/icons.fish 
  end

  setfont /usr/share/kbd/consolefonts/Lat2-Terminus16 ^/dev/null
  starship init fish | source
end

if type -q pyenv
  pyenv init - | source
end

if test -f $HOME/.poetry/env
  source $HOME/.poetry/env
end
