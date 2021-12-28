{config, pkgs, ...} : {
  home.packages = with pkgs; [
    efm-langserver
    tree
    jq
    nixpkgs-fmt
    rnix-lsp
    sumneko-lua-language-server
    clang-tools
    cmake
    ninja
  ];
}