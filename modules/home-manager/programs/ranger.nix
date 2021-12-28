{ config, lib, pkgs, ... }:
let
  cfg = config.programs.ranger;
  inherit (lib) mkEnableOption mkOption mkIf types;
in
{
  #TODO: Add options for commands , rc.conf features , optional deps.
  options.programs.ranger = {
    enable =
      mkEnableOption "ranger , terminal file manager";
    imagePreviewMethod = mkOption {
      default = null;
      type = types.nullOr types.str;
      description = ''
        Method to use for image preview.
        W3m does not work on macos.
        Try using iterm2 which'll work only on iterm2.
      '';
    };
  };

  config =
    let
      optionalString = name: val:
        lib.optionalString (val != null) "set ${name} ${val}";
    in
    mkIf cfg.enable {
      home.packages = [ pkgs.ranger ];
      xdg.configFile."ranger/rc.conf".text = ''
        ${optionalString "preview_images_method" cfg.imagePreviewMethod}
      '';
    };
}
