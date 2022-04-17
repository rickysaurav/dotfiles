{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    fzf
    ripgrep
  ];
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    completionInit = "";
    initExtraFirst = builtins.readFile ./.zshrc;
    envExtra = builtins.readFile ./.zshenv;
    profileExtra = builtins.readFile ./.zprofile;
    history = { path = ''''${ZDOTDIR:-$HOME}/.zsh_history''; size = 50000; save = 10000; };
  };
  xdg.configFile."zsh/del_init.zsh".source = ./del_init.zsh;
  xdg.configFile."zsh/.p10k.zsh".source = ./.p10k.zsh;
}
