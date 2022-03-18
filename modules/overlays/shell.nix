let
  myOverlay = import ./darwin-packages.nix;
  pkgs = import <nixpkgs> { overlays = [ myOverlay ]; };
in
pkgs.mkShell {
  buildInputs = with pkgs; [GoogleDrive];
}
