{ config, pkgs, ... }: {
  imports = [
    ./link_apps.nix
    ./programs
    ./fonts.nix
    ./lang.nix
    # ./dots/alacritty
    ./dots/tmux
    ./dots/ranger
    ./dots/nvim
    ./dots/zsh
    ./dots/emacs
    ./dots/bat
    ./dots/karabiner
    ./dots/wezterm
    ./dots/hammerspoon
  ];
  home.stateVersion = "22.05";
  programs.home-manager.enable = true;
}
