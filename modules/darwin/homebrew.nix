
{ pkgs, lib, ... }: {
  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
    };
    taps = [
      "homebrew/cask-drivers"
      "homebrew/cask"
    ];
    casks = [
      "docker"
      "google-chrome"
      "google-drive"
      "raycast"
      "spotify"
      "whatsapp"
      "karabiner-elements"
      "displaylink"
      "firefox"
      "logi-options-plus"
      "scroll-reverser"
      "linearmouse"
      "hammerspoon"
    ];
    masApps = {
      unsplash-wallpapers = 1284863847;
    };
  };
}
