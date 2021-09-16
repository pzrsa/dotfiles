# custom prompt
autoload -U colors && colors	# load colors

PROMPT="%B%{$fg[red]%}[%{$fg[white]%}%n%{$fg[red]%}@%{$fg[white]%}%M %{$fg[white]%}%2~%{$fg[red]%}]%{$fg[white]%} >%b "

# vim stuff
alias vi='nvim'
alias vim='nvim'
export EDITOR='nvim'
