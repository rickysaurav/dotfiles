{ config, lib, pkgs, ... }: {
  config = lib.mkIf (pkgs.stdenv.hostPlatform.isDarwin) {
    home.packages = with pkgs; [
      iterm2
    ];
  };
}