#TODO: Delete it later , it's annoying dealing with unversioned apps from nix.
{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    iterm2
    # casks.docker
    # casks.karabiner-elements
    Docker
    firefox-bin
    GoogleChrome
    Raycast
    Spotify
    Whatsapp
  ];
}
