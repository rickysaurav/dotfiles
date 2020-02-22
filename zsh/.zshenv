####EXPORT PATH####
export TERMCMD=alacritty
export GOPATH=~/go
export EDITOR="emacsclient -c -a \"\""
export VISUAL=$EDITOR
export ALTERNATE_EDITOR=nvim
export PATH=$HOME/.cargo/bin:$GOPATH/bin:$HOME/.local/bin:$PATH
#export TERM=xterm-256color
#export TERM=eterm-color
export FZF_TMUX=1
# ulimit -s 524144

####HISTORY####
#copied history configuration form oh my zsh
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000

####FZF CONFIG####
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --ignore-case --hidden --follow --glob "!.git/*" --glob "!.cache/*"'
