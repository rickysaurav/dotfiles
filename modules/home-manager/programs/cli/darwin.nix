{ config, lib, pkgs, ... }: {
  config = lib.mkIf (pkgs.stdenv.hostPlatform.isDarwin) {
    home.packages = with pkgs; [
      # podman needs qemu on macos
      qemu
    ];
  };
}