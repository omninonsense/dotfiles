function fish_greeting --description 'Welcome message'
  if not set -q __distro_name
    set -g __distro_name (cat /etc/lsb-release | awk -F= '/DISTRIB_DESCRIPTION/{print $2}' | sed 's/"//g')
  end

  echo -n "Welcome to" (set_color purple)"$__distro_name"(set_color normal)"! "
  echo "You're using" (set_color yellow)"Fish" (set_color normal)"as your shell. "
  echo "Today is" (date +"%A, %d.%m.%Y.")
  echo ""
end
