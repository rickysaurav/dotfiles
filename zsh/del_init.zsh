
####EXPORT PATH####
# export TERMCMD=alacritty
# export GOPATH=~/go
# export EDITOR="emacsclient -c -a \"\""
# export VISUAL=$EDITOR
# export ALTERNATE_EDITOR=nvim
# export PATH=$HOME/.cargo/bin:$GOPATH/bin:$HOME/.local/bin:$PATH
# #export TERM=xterm-256color
# #export TERM=eterm-color
# export FZF_TMUX=1
ulimit -s 524144


####HISTORY####
#copied history configuration form oh my zsh
# HISTFILE="$HOME/.zsh_history"
# HISTSIZE=50000
# SAVEHIST=10000
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data

##HIDDEN FILES##
setopt globdots

##FORCE READLINE MODE##
set -o emacs

####PYWAL COLORSCHEME####
#cat $HOME/.cache/wal/sequences


####FZF CONFIG####
# export FZF_DEFAULT_COMMAND='rg --files --no-ignore --ignore-case --hidden --follow --glob "!.git/*" --glob "!.cache/*"'
tm() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}
