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
    ];
    masApps = {
      unsplash-wallpapers = 1284863847;
    };
  };
  security.pam.enableSudoTouchIdAuth = true;
  system.defaults = {
    dock = {
      autohide = true;
      mru-spaces = false;
      orientation = "left";
      showhidden = true;
    };
    finder = {
      AppleShowAllExtensions = true;
      _FXShowPosixPathInTitle = true;
      FXEnableExtensionChangeWarning = false;
    };
    trackpad = {
      Clicking = true;
      # TrackpadThreeFingerDrag = true;
    };
    NSGlobalDomain = {
      AppleKeyboardUIMode = 3;
      ApplePressAndHoldEnabled = false;
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      _HIHideMenuBar = true;
    };
  };
}
