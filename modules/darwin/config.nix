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
    ];
    masApps =  {
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
      TrackpadThreeFingerDrag = true;
    };
    NSGlobalDomain = {
      ApplePressAndHoldEnabled = true;
      InitialKeyRepeat = 10;
      KeyRepeat = 2;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
    };
  };
}
