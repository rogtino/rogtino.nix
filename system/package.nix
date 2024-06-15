{
  pkgs,
  config,
  inputs,
  ...
}: {
  # lsp stuff should be in nix develop shell
  environment.systemPackages = with pkgs;
    [
      config.nur.repos.xddxdd.netease-cloud-music
      config.nur.repos.xddxdd.qqmusic
      # config.nur.repos.YisuiMilena.hmcl-bin
      # inputs.hyprpaper.packages.${pkgs.system}.default
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      libnotify
      mpv
      w3m-nox
      ffmpeg
      playerctl
      # emacs
      nodePackages.pnpm
      nodePackages_latest.prisma
      # python311Packages.torch-bin
      # cudaPackages.cudatoolkit
      python312
      nodejs
      grim
      mitscheme
      # vscode
      fzf
      cachix
      aircrack-ng
      cliphist
      just
      typst
      typst-preview
      telegram-desktop
      gnumake
      # this is super useful
      ngrok
      # cargo
      # rustup
      rust-bin.stable.latest.default
      clang
      luajit
      uiua
      devenv
      clang-tools
      swww
      bun
      sass
      yt-dlp
      gcc
      sqlite
      wl-clipboard
      waybar
      deno
      virt-manager
      neovim
      neovide
      rizin
      obs-studio
      cutter
      gh
      onefetch
      cliphist
      mate.atril
      slurp
      wlsunset
      # nodePackages.vscode-html-languageserver-bin
      wget
      flameshot
      # nvtop
      # daeuniverse.packages.x86_64-linux.daed
    ]
    ++ [
      inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
    ];
}
