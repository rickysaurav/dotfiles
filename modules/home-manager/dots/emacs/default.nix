{ config, pkgs, ... }: {
  programs.emacs = {
    enable = true;
  };
  home.packages = with pkgs; [
    ripgrep
  ];
  xdg.configFile."emacs" = { source = ../emacs; recursive = true; };
}
