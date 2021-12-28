{ config, pkgs, ... }: {
  #TODO: Update this to include nix specific stuff.
  home.packages = with pkgs; [
    fzf
    ripgrep
  ];
  xdg.configFile."zsh" = { source = ../zsh; recursive = true;};
  home.file.".zshenv".text = ''
    export ZDOTDIR=''${XDG_CONFIG_HOME:-$HOME/.config}/zsh
    source $ZDOTDIR/.zshenv
  '';
}
