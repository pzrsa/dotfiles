eval (/opt/homebrew/bin/brew shellenv)

alias c="clear"
alias vi="nvim"
fish_vi_key_bindings

source "/opt/homebrew/opt/fzf/shell/key-bindings.fish"
fzf_key_bindings

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

fnm env --use-on-cd --shell fish | source
