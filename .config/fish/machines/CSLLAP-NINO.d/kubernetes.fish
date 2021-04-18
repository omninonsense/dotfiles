set -x FISH_KUBECTL_COMPLETION_TIMEOUT 1s

add_to_path $HOME/.krew/bin

abbr -ag k kubectl
abbr -ag kap kubectl --context aws-prod
abbr -ag kas kubectl --context aws-shared
