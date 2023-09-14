{config, pkgs, ...} : {
  imports = [./darwin.nix];
  home.packages = with pkgs; [
    # language-tools
    sumneko-lua-language-server
    nodePackages.pyright
    nodePackages.typescript-language-server
    nodePackages.vim-language-server
    nodePackages.vscode-json-languageserver
    nodePackages.yaml-language-server
    rust-analyzer
    efm-langserver
    rnix-lsp
    nixpkgs-fmt
    # cli
    tree
    jq
    htop
    # compilers
    gcc
    cmake
    ninja
    # latex
    texlive.combined.scheme-full
    # containers
    podman
    podman-compose
  ];
}