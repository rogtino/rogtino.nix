{pkgs, ...}:
with pkgs; let
  lsp = [
    nil
    nodePackages."@astrojs/language-server"
    nodePackages."@prisma/language-server"
    typst-lsp
    marksman
    nodePackages_latest.typescript-language-server
    nodePackages_latest.vscode-css-languageserver-bin
    typescript
    rustywind
    emmet-language-server
    nodePackages."@tailwindcss/language-server"
    pyright
    sumneko-lua-language-server
    rust-analyzer
    cmake-language-server
    ruff
    nodePackages.bash-language-server
    # solc
  ];
  formatter = [
    taplo
    rustfmt
    alejandra
    cmake-format
    shfmt
    stylua
    black
    nodePackages_latest.prettier
  ];
  tools = [
    cowsay
    # manix
    htop-vim
    fastfetch
    yazi # terminal file manager
    commitizen
    nodePackages.conventional-changelog-cli
    gitui
    tealdeer
    zellij
    dust
  ];
  shtools = [
    zip
    killall
    xz
    file
    which
    gnused
    gnutar
    gawk
    zstd
    gnupg
    unzip
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
    lolcat
    toilet
    bat
    p7zip
    fd
    ripgrep
    glow
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor
  ];
in {
  home.packages = with pkgs;
    [
      bilibili
      # qq
      firefox
      google-chrome
      # nix related
      #
    ]
    ++ shtools
    ++ tools
    ++ lsp
    ++ formatter;
}
