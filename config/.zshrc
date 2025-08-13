HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
zstyle :compinstall filename '/home/doug/.zshrc'
autoload -Uz compinit
compinit

function set_win_title {
	echo -ne "\033]0;$(basename "$PWD")\007"
}

autoload -U add-zsh-hook
add-zsh-hook precmd set_win_title
eval "$(starship init zsh)"
