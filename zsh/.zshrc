####ZPLUGIN####
# Check if zplugin is installed
if [[ ! -d ~/.zplugin ]]; then
  # mkdir ~/.zplugin
  git clone https://github.com/zdharma/zplugin.git ~/.zplugin/bin
fi

####source zplugin####
source ~/.zplugin/bin/zplugin.zsh

####PLUGINS####
zplugin ice lucid wait \
        as:"program" \
        atclone:"./install --bin" \
        atpull:"%atclone" \
        pick:"bin/fzf" \
        multisrc:"shell/{key-bindings,completion}.zsh"
zplugin load "junegunn/fzf"

zplugin ice lucid wait pick:"init.sh"
zplugin load "b4b4r07/enhancd"

####THEMES####

zplugin ice wait atload'!source ~/.p10k.zsh' lucid nocd
zplugin load romkatv/powerlevel10k

# Load ~/.p10k-fancy.zsh when variable is set
zplugin id-as'fancy-prompt' nocd lucid \
    unload'[[ ! -v fancy ]]' \
    load'![[ -v fancy ]]' \
    atload'!source ~/.p10k-fancy.zsh; _p9k_precmd' for \
        zdharma/null

# Load ~/.p10k.zsh when in any other directory
zplugin id-as'normal-prompt' nocd lucid \
    unload'[[ -v fancy ]]' \
    load'![[ ! -v fancy ]]' \
    atload'!source ~/.p10k.zsh; _p9k_precmd' for \
        zdharma/null

# Lazy Load personal config
zplugin ice wait
zplugin snippet $HOME/del_init.zsh 

# Lazy compinit
zplugin id-as'compinit' wait:'0c' nocd lucid \
    atinit'zpcompinit' for \
        zdharma/null
