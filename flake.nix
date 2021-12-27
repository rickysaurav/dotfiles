{
  description = "Saurav Nix Environment";

  inputs = {
    # All packages should follow latest nixpkgs
    unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    # core
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "unstable";
    };
  };

  outputs = { self, nixpkgs, darwin, home-manager, ... }@inputs: {
    darwinConfigurations."saurav-macbook" = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        home-manager.darwinModule
        {
          home-manager = {
            useUserPackages = true;
            useGlobalPkgs = true;
          };
        }
        ({ pkgs, lib, ... }: {
          services.nix-daemon.enable = true;
          nixpkgs = {
            config.allowUnfree = true;
          };
          nix = {
            package = pkgs.nix;
            extraOptions = ''
              experimental-features = nix-command flakes
            '';
          };
          programs.zsh.enable = true;
          environment.systemPackages = with pkgs; [
            bat
            efm-langserver
            gcc
            htop
            neovim
            ranger
            alacritty
            ripgrep
            rnix-lsp
            stow
            sumneko-lua-language-server
            tmux
          ];
          fonts = {
            enableFontDir = true;
            fonts = with pkgs; [
              (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" "Iosevka" ]; })
            ];
          };
        })
      ];
    };
  };
}
