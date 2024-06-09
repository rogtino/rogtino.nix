{
  pkgs,
  config,
  # inputs,
  ...
}: {
  # lsp stuff should be in nix develop shell
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    libnotify
    mpv
    ffmpeg
    # emacs
    nodePackages.pnpm
    nodePackages_latest.prisma
    python312
    nodejs
    cachix
    just
    typst
    typst-preview
    cargo
    rustup
    clang
    luajit
    devenv
    clang-tools
    gcc
    sqlite
    wl-clipboard
    waybar
    deno
    neovim
    neovide
    rizin
    cutter
    gh
    onefetch
    cliphist
    zathura
    slurp
    swaybg
    wlsunset
    # nodePackages.vscode-html-languageserver-bin
    wget
  ];
}
