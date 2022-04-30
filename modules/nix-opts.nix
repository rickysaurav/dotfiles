{ config, pkgs, myLib, system, inputs, ... }:
{
  nix = {
    package = pkgs.nix;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
