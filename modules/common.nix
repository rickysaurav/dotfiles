{ config, pkgs, myLib, system, inputs, username, ... }:
let
  inherit (myLib) mkUser;
  inherit (pkgs.lib) mkOption types;
in
{
  config =
    {
      services.nix-daemon.enable = true;
      users.users.${username} = mkUser { inherit system username; };
      home-manager = {
        useUserPackages = true;
        useGlobalPkgs = true;
        users.${username} = import ./home-manager;
        # verbose = true;
      };
      programs.zsh = { enable = true; variables = { NOSYSZSHRC = "true"; }; };
    };
}
