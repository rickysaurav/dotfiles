{ config, pkgs, myLib, system, ... }:
let
  inherit (myLib) mkUser;
  inherit (pkgs.lib) mkOption types;
in
{
  options = {
    user = {
      userName = mkOption {
        description = "userName";
        type = types.str;
        default = "ricky_saurav";
      };
    };
  };
  config = let userName = config.user.userName; in
    {
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
      users.users.${userName} = mkUser { inherit system userName; };
      home-manager = {
        useUserPackages = true;
        useGlobalPkgs = true;
        users.${userName} = import ./home-manager;
        # verbose = true;
      };
      programs.zsh.enable = true;
    };
}
