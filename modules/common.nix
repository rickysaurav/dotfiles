{ config, pkgs, myLib, system, inputs, ... }:
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
      users.users.${userName} = mkUser { inherit system userName; };
      home-manager = {
        useUserPackages = true;
        useGlobalPkgs = true;
        users.${userName} = import ./home-manager;
        # verbose = true;
      };
      programs.zsh = { enable = true; variables = { NOSYSZSHRC = "true"; }; };
    };
}
