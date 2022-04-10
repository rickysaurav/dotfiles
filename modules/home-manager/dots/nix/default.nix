{ config, pkgs, ... }: {
  xdg.configFile."nix/nix.conf".source = ./nix.conf;
}
