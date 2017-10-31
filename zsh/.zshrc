# Created by newuser for 5.4.1
(wal -t -r &)
export GOPATH=~/go
export EDITOR=nvim
export PATH=$PATH:/usr/bin/core_perl:$HOME/.rvm/bin:/usr/lib/w3m:$GOPATH/bin
export TERM=xterm-256color
export FZF_TMUX=1
ulimit -s 524144

####source  oh-my-zsh  and zplug ######
export ZSH=~/.zplug/repos/robbyrussell/oh-my-zsh 
source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/scripts/zplug/init.zsh 


#. /usr/share/zsh/site-contrib/powerline.zsh

####PLUGINS#####
zplug "zsh-users/zsh-history-substring-search", defer:3
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "arzzen/calc.plugin.zsh"
zplug "b4b4r07/enhancd", use:init.sh
zplug "zplug/zplug"
zplug "plugins/pip", from:oh-my-zsh 
zplug "plugins/npm", from:oh-my-zsh 

####THEMES######
#zplug "themes/fino-time", from:oh-my-zsh, as:theme
#zplug "mashaal/wild-cherry", use:zsh/wild-cherry.zsh-theme
#zplug "zakaziko99/agnosterzak-ohmyzsh-theme", use:agnosterzak.zsh-theme
#zplug mafredri/zsh-async, from:github
#zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme
zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme

#####THEME SETTINGS####
POWERLEVEL9K_MODE='nerdfont-complete'
#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir rbenv vcs)
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir dir_writable vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs battery os_icon time)
POWERLEVEL9K_BATTERY_STAGES="▁▂▃▄▅▆▇█"
#POWERLEVEL9K_BATTERY_STAGES=(
   #$'▏    ▏' $'▎    ▏' $'▍    ▏' $'▌    ▏' $'▋    ▏' $'▊    ▏' $'▉    ▏' $'█    ▏'
   #$'█▏   ▏' $'█▎   ▏' $'█▍   ▏' $'█▌   ▏' $'█▋   ▏' $'█▊   ▏' $'█▉   ▏' $'██   ▏'
   #$'██   ▏' $'██▎  ▏' $'██▍  ▏' $'██▌  ▏' $'██▋  ▏' $'██▊  ▏' $'██▉  ▏' $'███  ▏'
   #$'███  ▏' $'███▎ ▏' $'███▍ ▏' $'███▌ ▏' $'███▋ ▏' $'███▊ ▏' $'███▉ ▏' $'████ ▏'
   #$'████ ▏' $'████▎▏' $'████▍▏' $'████▌▏' $'████▋▏' $'████▊▏' $'████▉▏' $'█████▏' )
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

# ftpane - switch pane (@george-b)
ftpane() {
  local panes current_window current_pane target target_window target_pane
  panes=$(tmux list-panes -s -F '#I:#P - #{pane_current_path} #{pane_current_command}')
  current_pane=$(tmux display-message -p '#I:#P')
  current_window=$(tmux display-message -p '#I')

  target=$(echo "$panes" | grep -v "$current_pane" | fzf +m --reverse) || return

  target_window=$(echo $target | awk 'BEGIN{FS=":|-"} {print$1}')
  target_pane=$(echo $target | awk 'BEGIN{FS=":|-"} {print$2}' | cut -c 1)

  if [[ $current_window -eq $target_window ]]; then
    tmux select-pane -t ${target_window}.${target_pane}
  else
    tmux select-pane -t ${target_window}.${target_pane} &&
    tmux select-window -t $target_window
  fi
}

##export PATH="$PATH:$HOME/.rvm/bin:$HOME/psiphon-psiphon-circumvention-system-d03bb2db3683/pyclient" # Add RVM to PATH for scripting
