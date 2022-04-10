{config, pkgs, ...} : {
  imports = [
    ./common.nix
    ./darwin.nix
  ];
}