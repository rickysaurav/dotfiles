lib: { system, userName }: {
  name = userName;
  home = lib.homeDirectory { inherit userName system; };
}
