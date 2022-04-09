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
      aarch64-darwin = "aarch64-darwin";
      darwin-overlays = [
        inputs.firefox-darwin.overlay
      ];
    in
    {
      darwinConfigurations."saurav-macbook" =
        let system = aarch64-darwin;
        in
        darwin.lib.darwinSystem {
          inherit system;
          modules = [
            home-manager.darwinModule
            ./modules/darwin
            ./modules/common.nix
          ];
          specialArgs = { overlays = darwin-overlays; inherit inputs myLib nixpkgs system; };
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
