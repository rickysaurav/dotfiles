{config, pkgs, ...} : {
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" "Iosevka" ]; })
  ];
  fonts.fontconfig.enable = true;
}