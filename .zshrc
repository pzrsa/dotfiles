# git branch
function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

COLOR_USR=$'\e[38;5;250m'
COLOR_DIR=$'\e[38;5;255m'
COLOR_GIT=$'\e[38;5;250m'
NEWLINE=$'\n'
COLOR_DEF=$'\e[38;5;250m'
setopt PROMPT_SUBST

# custom prompt
export PROMPT='%B${COLOR_USR}%n ${COLOR_DIR}%~ ${COLOR_GIT}$(parse_git_branch)${COLOR_DEF}${NEWLINE}➜%b '

# adds to $PATH
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# For compilers to find openssl@1.1 you may need to set:
export LDFLAGS="-L/opt/homebrew/opt/openssl@1.1/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@1.1/include"

# For pkg-config to find openssl@1.1 you may need to set:
export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@1.1/lib/pkgconfig"

# other stuff
alias vi='nvim'
alias c='clear'
unsetopt LIST_BEEP
export TERM=xterm-256color

# enable ls colors
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc' ]; then . '/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc' ]; then . '/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'; fi

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
