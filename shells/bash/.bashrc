source "$HOME/dotfiles/shells/bash/bash-powerline.sh"
source "$HOME/dotfiles/shells/env"

# kubectl completions
if command -v kubectl &> /dev/null; then
    source <(kubectl completion bash)
fi

if command -v k3d &> /dev/null; then
    source <(k3d completion bash)
fi
