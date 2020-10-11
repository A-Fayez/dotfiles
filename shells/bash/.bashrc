source "$HOME/dotfiles/shells/bash/bash-powerline.sh"
source "$HOME/dotfiles/shells/env"

# kubectl completions
if kubectl version --client >/dev/null 2>&1; then
    source <(kubectl completion bash)
fi
