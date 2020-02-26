####ZINIT####
# Check if zinit is installed
if [[ ! -d ~/.zinit ]]; then
  # mkdir ~/.zinit
  git clone https://github.com/zdharma/zinit.git ~/.zinit/bin
fi

####source zinit####
source ~/.zinit/bin/zinit.zsh

####THEMES####

zinit ice wait atload'!source ~/.p10k.zsh' lucid nocd
zinit load romkatv/powerlevel10k

# Load ~/.p10k-fancy.zsh when variable is set
zinit id-as'fancy-prompt' nocd lucid \
    unload'[[ ! -v fancy ]]' \
    load'![[ -v fancy ]]' \
    atload'!source ~/.p10k-fancy.zsh; _p9k_precmd' for \
        zdharma/null

# Load ~/.p10k.zsh when in any other directory
zinit id-as'normal-prompt' nocd lucid \
    unload'[[ -v fancy ]]' \
    load'![[ ! -v fancy ]]' \
    atload'!source ~/.p10k.zsh; _p9k_precmd' for \
        zdharma/null

# Lazy Load personal config
zinit ice lucid wait
zinit snippet $HOME/del_init.zsh

####PLUGINS####
zinit ice lucid wait \
        as:"program" \
        atclone:"./install --bin" \
        atpull:"%atclone" \
        pick:"bin/fzf" \
        multisrc:"shell/{key-bindings,completion}.zsh"
zinit load "junegunn/fzf"

zinit ice lucid wait pick:"init.sh"
zinit load "b4b4r07/enhancd"


# Lazy compinit
zinit id-as'compinit' wait:'0c' nocd lucid \
    atinit'zpcompinit' for \
        zdharma/null
