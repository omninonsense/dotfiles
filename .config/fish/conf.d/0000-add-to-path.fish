function add_to_path --description "Add a directory to the path if it exists"
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
    set -gxp PATH "$location"
  else
    $atp_debug || $atp_warn && echo $atp_warn_prefix (set_color red)$location(set_color normal)" isn't a directory"(set_color normal)
  end
end
