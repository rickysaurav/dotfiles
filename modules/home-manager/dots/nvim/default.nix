{ config, pkgs, ... }: {
  xdg.configFile."nvim" = { source = ../nvim; recursive = true; };
  home.packages = with pkgs; [
    # neovim
    (wrapNeovimUnstable neovim-unwrapped (neovimUtils.makeNeovimConfig {
      withPython3 = false;
      withRuby = false;
      wrapRc = false;
    }))
    ripgrep
    bat
  ];
}
