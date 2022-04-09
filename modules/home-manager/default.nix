{ config, pkgs, ... }: {
  imports = [
    ./link_apps.nix
    ./packages.nix
    # ./darwin_apps.nix
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
