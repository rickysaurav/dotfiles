{ config, pkgs, overlays,... }: {
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
    ./dots/karabiner
    ./dots/nix
  ];
  nixpkgs = {
    config.allowUnfree = true;
    inherit overlays;
  };
  programs.home-manager.enable = true;
}
