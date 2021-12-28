{ config, pkgs, ... }: {
  imports = [
    ./link_apps.nix
    ./dev_tools.nix
    ./fonts.nix
    # ./dots/alacritty
    ./dots/tmux
    ./dots/ranger
    ./dots/nvim
    ./dots/zsh
    ./dots/emacs
    ./dots/bat
  ];
  programs.home-manager.enable = true;
}
