lib: { system, username }: {
  name = username;
  home = lib.homeDirectory { inherit username system; };
}
