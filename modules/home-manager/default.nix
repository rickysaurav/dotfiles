{ config, pkgs, ... }: {
  programs.home-manager.enable = true;
  programs.bash.enable = true;
  home.packages = with pkgs; [
    bat
    efm-langserver
    gcc
    htop
    neovim
    nixpkgs-fmt
    (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" "Iosevka" ]; })
    ranger
    alacritty
    ripgrep
    rnix-lsp
    stow
    sumneko-lua-language-server
    tmux
    tree
  ];
}
