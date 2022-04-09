{ config, lib, pkgs, ... }: {
  config = lib.mkIf (pkgs.stdenv.hostPlatform.isDarwin) {
    xdg.configFile."karabiner" = { source = ../karabiner; recursive = true; };
  };
}
