
{ pkgs, lib, ... }: {
  homebrew = {
    enable = true;
    cleanup = "zap";
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
      "wezterm"
    ];
    masApps = {
      unsplash-wallpapers = 1284863847;
    };
  };
}
