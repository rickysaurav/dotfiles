{config, pkgs, ...} : {
  home.packages = with pkgs; [
    # language-tools
    efm-langserver
    rnix-lsp
    nixpkgs-fmt
    clang-tools
    sumneko-lua-language-server
    cmake
    ninja
    # cli
    tree
    jq
    htop
  ];
}