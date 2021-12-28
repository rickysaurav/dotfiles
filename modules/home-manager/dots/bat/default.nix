{ pkgs, lib, ... }: {
  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
      style = "numbers,changes";
    };
  };
}
