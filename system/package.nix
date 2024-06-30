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
      pnpm
      nodePackages.ts-node
      nodePackages_latest.prisma
      # python311Packages.torch-bin
      # cudaPackages.cudatoolkit
      python312
      nodejs
      go
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
      yq
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
      dart-sass
      brightnessctl
      yt-dlp
      gcc
      sqlite
      wl-clipboard
      deno
      virt-manager
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
  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
  };
}
