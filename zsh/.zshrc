# Created by newuser for 5.4.1
cat /home/ricky_saurav/.cache/wal/sequences
export TERMCMD=alacritty
export GOPATH=~/go
export EDITOR="emacsclient -c -a \"\""
export VISUAL=$EDITOR
export ALTERNATE_EDITOR=nvim
# export PATH=/usr/bin/core_perl:$HOME/.rvm/bin:/usr/lib/w3m:$GOPATH/bin:$HOME/bin:$HOME/.local/bin:$PATH
export PATH=$HOME/.cargo/bin:$GOPATH/bin:$HOME/.local/bin:$PATH
# export TERM=xterm-256color
#export TERM=eterm-color
export FZF_TMUX=1
ulimit -s 524144


####ZPLUG####
# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi

####source  oh-my-zsh  and zplug ######
# export ZSH=~/.zplug/repos/robbyrussell/oh-my-zsh
# source $ZSH/oh-my-zsh.sh
source ~/.zplug/init.zsh

####PLUGINS#####
zplug "junegunn/fzf", as:command, hook-build:"./install --all"
zplug "zsh-users/zsh-history-substring-search", defer:3
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "b4b4r07/enhancd", use:init.sh
zplug "zplug/zplug"

####THEMES######
if [ -f ~/p10k-config.zsh ]; then
    source ~/p10k-config.zsh
else
    zplug "romkatv/powerlevel10k", use:config/p10k-pure.zsh
fi
zplug "romkatv/powerlevel10k", use:powerlevel10k.zsh-theme

# Install packages that have not been installed yet
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    else
        echo
    fi
fi

#####POWERLEVEL9K THEME SETTINGS####
# POWERLEVEL9K_MODE='nerdfont-complete'
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(user dir dir_writable virtualenv vcs)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs battery time)
# POWERLEVEL9K_TIME_FORMAT='%D{%H:%M}'
# POWERLEVEL9K_USER_ICON="\uF415" # 
# POWERLEVEL9K_ROOT_ICON="#"
# POWERLEVEL9K_BATTERY_STAGES="▁▂▃▄▅▆▇█"

#####SPACESHIP-PROMPT THEME SETTINGS####
# SPACESHIP_TIME_SHOW='true'
# SPACESHIP_BATTERY_SHOW='always'
# SPACESHIP_BATTERY_THRESHOLD=90
# SPACESHIP_TIME_FORMAT='%D{%H:%M}'

#####LOAD ######
zplug load


#####FZF########
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --ignore-case --hidden --follow --glob "!.git/*" --glob "!.cache/*"'
if zplug check b4b4r07/enhancd; then
    # setting if enhancd is available
    export ENHANCD_FILTER=fzf
fi

bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
# tm - create new tmux session, or switch to existing one. Works from within tmux too. (@bag-man)
# `tm` will allow you to select your tmux session via fzf.
# `tm irc` will attach to the irc session (if it exists), else it will create it.
tm() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}
