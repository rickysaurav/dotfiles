
{ config, lib, pkgs, ... }:{
 imports = [./homebrew.nix ./system.nix ./config.nix ./pam.nix];
}