cat $HOME/.cache/wal/sequences
export TERMCMD=alacritty
export GOPATH=~/go
export EDITOR="emacsclient -c -a \"\""
export VISUAL=$EDITOR
export ALTERNATE_EDITOR=nvim
export PATH=$HOME/.cargo/bin:$GOPATH/bin:$HOME/.local/bin:$PATH
#export TERM=xterm-256color
#export TERM=eterm-color
export FZF_TMUX=1
ulimit -s 524144


####HISTORY####
#copied history configuration form oh my zsh
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data


####ZPLUGIN####
# Check if zplugin is installed
if [[ ! -d ~/.zplugin ]]; then
  # mkdir ~/.zplugin
  git clone https://github.com/zdharma/zplugin.git ~/.zplugin/bin
fi

####source zplugin####
source ~/.zplugin/bin/zplugin.zsh


####PLUGINS####
zplugin ice wait \
        as:"program" \
        atclone:"./install --bin" \
        atpull:"%atclone" \
        pick:"bin/fzf" \
        multisrc:"shell/{key-bindings,completion}.zsh"
zplugin load "junegunn/fzf"

zplugin ice wait pick:"init.sh"
zplugin load "b4b4r07/enhancd"


####THEMES####

zplugin ice wait'!' \
        lucid \
        nocd \
        atload:'source ~/.p10k.zsh; _p9k_precmd' \
        wrap-track:'_p9k_precmd'
zplugin load romkatv/powerlevel10k

#TODO: Figure out a way to load different prompts at different conditions
#unstable
# zplugin ice load'![[ -v fancy ]]' unload'![[ ! -v fancy ]]'
# zplugin snippet '~/.p10k-fancy.zsh'



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

#TODO:convert into snippets for lazy loading
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --ignore-case --hidden --follow --glob "!.git/*" --glob "!.cache/*"'
tm() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}
