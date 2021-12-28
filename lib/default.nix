lib:
let myLib = import ./home_utils.nix lib;
# in lib.recursiveUpdate myLib { mkUser = import ./user_utils.nix myLib; }
in myLib // { mkUser = import ./user_utils.nix myLib; }
