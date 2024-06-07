{
  pkgs,
  config,
  # inputs,
  ...
}: {
  # lsp stuff should be in nix develop shell
  environment.systemPackages = with pkgs; [
    config.nur.repos.rewine.electron-netease-cloud-music
    config.nur.repos.xddxdd.qqmusic
    config.nur.repos.YisuiMilena.hmcl-bin
    # inputs.hyprpaper.packages.${pkgs.system}.default
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    libnotify
    mpv
    ffmpeg
    # emacs
    nodePackages.pnpm
    nodePackages_latest.prisma
    python311Packages.torch-bin
    # cudaPackages.cudatoolkit
    python312
    nodejs
    grim
    cachix
    aircrack-ng
    cliphist
    just
    typst
    typst-preview
    telegram-desktop
    # this is super useful
    ngrok
    cargo
    rustup
    clang
    luajit
    devenv
    clang-tools
    yt-dlp
    gcc
    sqlite
    wl-clipboard
    waybar
    deno
    virt-manager
    # neovim
    # neovide
    rizin
    rofi-wayland
    obs-studio
    cutter
    gh
    onefetch
    cliphist
    zathura
    mate.atril
    slurp
    swaybg
    wlsunset
    # nodePackages.vscode-html-languageserver-bin
    wget
    flameshot
    # nvtop
    # daeuniverse.packages.x86_64-linux.daed
  ];
}
