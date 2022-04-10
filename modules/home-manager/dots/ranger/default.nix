{config,pkgs,...}:{
home.packages = with pkgs; [
    ranger
];
xdg.configFile."ranger/commands.py".source = ./commands.py;
xdg.configFile."ranger/rc.conf".source = ./rc.conf;
xdg.configFile."ranger/devicons.py".source = ./devicons.py;
xdg.configFile."ranger/plugins/devicons_linemode.py".source = ./plugins/devicons_linemode.py;
}