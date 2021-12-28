{config,pkgs,...}:{
 imports = [../../programs/ranger.nix];
 programs.ranger = {
     enable = true;
     imagePreviewMethod = "iterm2";
 };
}