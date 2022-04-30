lib:
let
  isDarwin = system: (builtins.elem system lib.platforms.darwin);
  homePrefix = system: if isDarwin system then "/Users" else "/home";
in
{
  inherit isDarwin homePrefix;
  homeDirectory = { system, username }: "${homePrefix system}/${username}";
}
