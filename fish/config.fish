eval (/opt/homebrew/bin/brew shellenv)

alias c="clear"
alias vi="nvim"
alias lg="lazygit"
alias ls="eza -l --icons"
alias g="git"

set -g fish_key_bindings fish_vi_key_bindings

source "/opt/homebrew/opt/fzf/shell/key-bindings.fish"
fzf_key_bindings

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export EDITOR=nvim

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end
