let
  pkgs = import <nixpkgs> { overlays = [ (import ./darwin-packages.nix)]; };
in
pkgs.mkShell {
  buildInputs = with pkgs; [GoogleDrive];
}
