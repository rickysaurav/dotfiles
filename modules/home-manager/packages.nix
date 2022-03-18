{config, pkgs, ...} : {
  home.packages = with pkgs; [
    # editors
    vscode
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
  ];
}