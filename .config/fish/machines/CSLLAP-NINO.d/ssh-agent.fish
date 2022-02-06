# https://www.youtube.com/watch?v=UvjLgjtJKsc
set -x SSH_AUTH_SOCK /run/user/(id -u)/keyring/ssh
# ssh-agent -c | source
# echo "export "(gnome-keyring-daemon -s) | source
