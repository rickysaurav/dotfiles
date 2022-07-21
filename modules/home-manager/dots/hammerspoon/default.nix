{ config, lib, pkgs, ... }: {
  config = lib.mkIf (pkgs.stdenv.hostPlatform.isDarwin) {
    home.file.".hammerspoon" = {source = ../hammerspoon; recursive= true;};
  };
}
