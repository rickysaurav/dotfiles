{config, pkgs, ...} : {
  imports = [./darwin.nix];
  home.packages = with pkgs; [
    # editors
    vscode
    wezterm
    discord
    zoom-us
    spotify
  ];
}