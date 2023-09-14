
{ pkgs, lib, ... }: {
  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
    };
    taps = [
      "homebrew/cask-drivers"
      "homebrew/cask"
      "homebrew/cask-versions"
    ];
    casks = [
      "firefox"
      "microsoft-edge"
      "google-chrome"
      "google-drive"
      "raycast"
      "spotify"
      "karabiner-elements"
      "displaylink"
      "logi-options-plus"
      "linearmouse"
      "hammerspoon"
      "whatsapp-alpha"
    ];
    masApps = {
      unsplash-wallpapers = 1284863847;
    };
  };
}
