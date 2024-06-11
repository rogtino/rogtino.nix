{
  pkgs,
  config,
  ...
}:
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
  inherit (config.lib.file) mkOutOfStoreSymlink;
in {
  programs = {
    fish.enable = true;
    git = {
      enable = true;
      userName = "rogtino";
      userEmail = "rogtino@proton.me";
      extraConfig = {
        # http.postBuffer = "4096M";
        credential = {
          helper = "store";
        };
      };
      ignores = [".direnv" "node_modules"];
    };
    zoxide = {
      enable = true;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    # 启用 starship，这是一个漂亮的 shell 提示符
    starship = {
      enable = true;
    };

    lazygit = {
      enable = true;
      settings = {
        customCommands = [
          {
            key = "Z";
            command = "git cz c";
            description = "commit with commitizen";
            context = "files";
            loadingText = "opening commitizen commit tool";
            subprocess = true;
          }
        ];
      };
    };
    bash = {
      enable = true;
      enableCompletion = true;
      # TODO 在这里添加你的自定义 bashrc 内容
      bashrcExtra = ''
        export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
      '';

      # TODO 设置一些别名方便使用，你可以根据自己的需要进行增删
      shellAliases = {
        #k = "kubectl";
        asd = "lazygit";
        e = "nvim";
        q = "exit";
        zj = "zellij";
        cdtmp = "cd $(mktemp -d)";
        update = "sudo nixos-rebuild switch --impure";
      };
    };
  };
  home.file.".npmrc" = {
    text = ''
      prefix=~/.npm-packages
      registry=https://registry.npmmirror.com
    '';
  };
  xdg = {
    enable = true;

    configFile = {
      "nvim" = {
        source = mkOutOfStoreSymlink "/home/gus/rogtino.nix/config/nvim";
      };
      "nushell" = {
        source = mkOutOfStoreSymlink "/home/gus/rogtino.nix/config/nushell";
      };
      "zellij" = {
        source = ../config/zellij;
      };
    };
  };
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
