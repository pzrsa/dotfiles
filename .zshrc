# git branch
function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

COLOR_DEF=$'\e[0m'
COLOR_USR=$'\e[38;5;243m'
COLOR_DIR=$'\e[38;5;197m'
COLOR_GIT=$'\e[38;5;39m'
NEWLINE=$'\n'
setopt PROMPT_SUBST

# custom prompt
export PROMPT='%B${COLOR_USR}%n ${COLOR_DIR}%~ ${COLOR_GIT}$(parse_git_branch)${COLOR_DEF}${NEWLINE}➜%b '

autoload -Uz compinit
compinit

# other stuff
alias vi='nvim'
alias c='clear'
alias gs='git status'
alias gp='git push'

unsetopt LIST_BEEP
export TERM=xterm-256color

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


# To activate the syntax highlighting, add the following at the end of your .zshrc:
source "/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# To activate the autosuggestions, add the following at the end of your .zshrc:
source "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
