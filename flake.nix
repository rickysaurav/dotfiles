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
      linux-overlays = [];
      username = "ricky_saurav";
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
        homeConfigurations."${username}-linux-config" = let system = "x86_64-linux";in home-manager.lib.homeManagerConfiguration {
        # Specify the path to your home configuration here
        configuration = import ./modules/home-manager;
        stateVersion = "22.05";
        inherit system username;
        homeDirectory = myLib.homeDirectory {
          inherit system;
          userName = username;
        };
        # Optionally use extraSpecialArgs
        extraSpecialArgs = { overlays = linux-overlays; inherit inputs myLib nixpkgs system; };
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
