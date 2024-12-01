#### Do not pollute home ####
: "${ZDOTDIR:=$HOME}"
####ZINIT####
# Check if zinit is installed
if [[ ! -d $ZDOTDIR/.zinit ]]; then
  # mkdir $ZDOTDIR/.zinit
  git clone https://github.com/zdharma-continuum/zinit.git $ZDOTDIR/.zinit/bin
fi

####source zinit####
source $ZDOTDIR/.zinit/bin/zinit.zsh

####THEMES####

 zinit ice atload'source $ZDOTDIR/.p10k.zsh || true; _p9k_precmd' \
    lucid nocd
 zinit load romkatv/powerlevel10k

# Lazy Load personal config
zinit ice lucid wait
zinit snippet $ZDOTDIR/del_init.zsh

###SYNTAX###
zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions

####PLUGINS####
zinit ice lucid wait \
        multisrc:"shell/{key-bindings,completion}.zsh"
zinit load "junegunn/fzf"

zinit ice lucid wait pick:"fzf-tab.zsh"
zinit load "Aloxaf/fzf-tab"

# Lazy compinit
zinit id-as'compinit' wait:'0c' nocd lucid \
    atinit'zpcompinit' for \
        zdharma-continuum/null
