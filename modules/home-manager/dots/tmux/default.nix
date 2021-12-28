{ config, pkgs, ... }: {
  programs.tmux = {
    enable = true;
  };
  xdg.configFile."tmux/tmux.conf".source = ./.tmux.conf;
  xdg.configFile."tmux/statusline.conf".source = ./statusline.conf;
  xdg.configFile."tmux/statusline_alter.conf".source = ./statusline_alter.conf;
}
