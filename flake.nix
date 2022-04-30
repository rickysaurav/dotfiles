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
    firefox-darwin.url = "github:bandithedoge/nixpkgs-firefox-darwin";
  };

  outputs = { self, nixpkgs, darwin, home-manager, ... }@inputs:
    let
      myLib = import ./lib nixpkgs.lib;
      constants = import ./constants.nix;
      darwin-overlays = [
        inputs.firefox-darwin.overlay
      ];
      linux-overlays = [ ];
      username = "ricky_saurav";
      mkHomeManagerConfig =
        { system
        , username
        , ...
        }@args: home-manager.lib.homeManagerConfiguration (args // {
          configuration = import ./modules/home-manager;
          stateVersion = "22.05";
          inherit system username;
          homeDirectory = myLib.homeDirectory {
            inherit system;
            userName = username;
          };
        });
      config = { allowUnfree = true; };
    in
    {
      darwinConfigurations."saurav-macbook" =
        let
          system = constants.aarch64-darwin;
        in
        let
          pkgs = import nixpkgs {
            inherit config system;
            overlays = darwin-overlays;
          };
        in
        darwin.lib.darwinSystem {
          inherit system pkgs;
          modules = [
            home-manager.darwinModule
            ./modules/nix-opts.nix
            ./modules/darwin
            ./modules/common.nix
          ];
          specialArgs = { overlays = darwin-overlays; inherit inputs myLib nixpkgs system; };
        };
      homeConfigurations."saurav-linux-config" =
        let
          system = constants.x86_64-linux;
        in
        let
          username = constants.ricky_saurav;
          pkgs = import nixpkgs {
            inherit config system;
            overlays = linux-overlays;
          };
        in
        mkHomeManagerConfig {
          inherit system pkgs username;
          extraSpecialArgs = { inherit inputs myLib nixpkgs system constants; };
          extraModules = [./modules/nix-opts.nix];
        };
      homeConfigurations."saurav-linux-arm-config" =
        let
          system = constants.aarch64-linux;
        in
        let
          username = constants.ricky_saurav;
          pkgs = import nixpkgs {
            inherit config system;
            overlays = linux-overlays;
          };
        in
        mkHomeManagerConfig {
          inherit system pkgs username;
          extraSpecialArgs = { inherit inputs myLib nixpkgs system constants; };
          extraModules = [./modules/nix-opts.nix];
        };
      # #TODO: Fix this later
      # devShell.aarch64-darwin =
      #   with pkgs;
      #   mkShell {
      #     nativeBuildInputs = [ unpkg undmg ];
      #   }
      # ;
    };
}
