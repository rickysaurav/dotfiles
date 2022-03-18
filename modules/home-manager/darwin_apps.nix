{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    Docker
    firefox-bin
    GoogleChrome
    # GoogleDrive
    iTerm2
    Raycast
    Spotify
    Whatsapp
  ];
}
