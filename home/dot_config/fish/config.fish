eval (/opt/homebrew/bin/brew shellenv)

alias c="clear"
alias vi="nvim"
alias lg="lazygit"
alias ls="eza -la --icons"
alias cd="z"
export EDITOR=hx

set -g fish_key_bindings fish_vi_key_bindings
set -g fish_greeting

source "/opt/homebrew/opt/fzf/shell/key-bindings.fish"
fzf_key_bindings

fish_add_path /opt/homebrew/bin
fish_add_path --move /opt/homebrew/opt/node@20/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.bun/bin
fish_add_path /Applications/Obsidian.app/Contents/MacOS

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

zoxide init fish | source
