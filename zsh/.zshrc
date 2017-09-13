# Created by newuser for 5.4.1
(wal -t -r &)
export PATH=$PATH:/usr/bin/core_perl:$HOME/.rvm/bin:/usr/lib/w3m
export ZSH=~/.zplug/repos/robbyrussell/oh-my-zsh 
source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/scripts/zplug/init.zsh 
ulimit -s 524144
#export TERM=xterm-256color
#export LC_ALL=en_US.UTF-8
#export LANG=en_US.UTF-8
. /usr/share/zsh/site-contrib/powerline.zsh
zplug "zsh-users/zsh-history-substring-search", defer:3
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "arzzen/calc.plugin.zsh"
zplug "b4b4r07/enhancd", use:init.sh
#zplug "mashaal/wild-cherry", use:zsh/wild-cherry.zsh-theme
#zplug "zakaziko99/agnosterzak-ohmyzsh-theme", use:agnosterzak.zsh-theme
zplug "zplug/zplug"
#zplug "themes/agnoster", from:oh-my-zsh
#zplug "themes/fino-time", from:oh-my-zsh, as:theme
zplug "plugins/pip", from:oh-my-zsh 
zplug "plugins/npm", from:oh-my-zsh 
zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme
#zplug mafredri/zsh-async, from:github
#zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --ignore-case --hidden --follow --glob "!.git/*"'
if zplug check b4b4r07/enhancd; then
    # setting if enhancd is available
    export ENHANCD_FILTER=fzf
fi
 
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
zplug load
##export PATH="$PATH:$HOME/.rvm/bin:$HOME/psiphon-psiphon-circumvention-system-d03bb2db3683/pyclient" # Add RVM to PATH for scripting
