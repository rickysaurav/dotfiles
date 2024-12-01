
{ pkgs, lib, ... }: {
  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
    };
    taps = [
      "homebrew/cask-drivers"
      "homebrew/cask-versions"
    ];
    casks = [
      "firefox"
      "google-chrome"
      "google-drive"
      "raycast"
      "displaylink"
      "logi-options-plus"
      "hammerspoon"
      "whatsapp@beta"
    ];
    masApps = {
      unsplash-wallpapers = 1284863847;
    };
  };
}
