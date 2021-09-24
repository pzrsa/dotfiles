# custom prompt
PROMPT="%B%F{#ADD7FF}%2~ %f%b%B%F{#A6ACCD}〉%f%b"

# other stuff
alias vi='nvim'
alias c='clear'
unsetopt LIST_BEEP

# enable ls colors
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'
