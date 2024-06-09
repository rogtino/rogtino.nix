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
    grc
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
    fzf
    glow
  ];
  link = config.lib.file.mkOutOfStoreSymlink;
in {
  home.username = "gus";
  home.homeDirectory = "/home/gus";
  home.file.".npmrc" = {
    text = ''
      prefix=~/.npm-packages
      registry=https://registry.npmmirror.com
    '';
  };
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };
  xdg = {
    enable = true;

    configFile = {
      "nvim" = {
        source = link "/home/gus/rogtino.nix/config/nvim";
      };
      "zathura" = {
        source = ../../config/zathura;
      };
      "alacritty" = {
        source = ../../config/alacritty;
      };
      "zellij" = {
        source = ../../config/zellij;
      };
    };
  };

  home.packages = with pkgs;
    [
      # it provides the command `nom` works just like `nix`
      # with more details log output
      nix-output-monitor
    ]
    ++ shtools
    ++ tools
    ++ lsp
    ++ formatter;

  programs = {
    command-not-found.enable = true;
    # TODO: try photon
    newsboat = {
      enable = true;
      maxItems = 50;
      autoReload = true;
      urls = [{url = "https://www.zhihu.com/rss";}];
      extraConfig = ''
        # externel browser
        # browser "/usr/local/bin/w3m %u"
        # macro m set browser "/usr/local/bin/mpv %u"; open-in-browser ; set browser "/usr/local/bin/w3m %u"
        # macro l set browser "/usr/local/bin/firefox %u"; open-in-browser ; set browser "/usr/local/bin/w3m %u"
        # unbind keys
        unbind-key ENTER
        unbind-key j
        unbind-key k
        unbind-key J
        unbind-key K
        # bind keys - vim style
        bind-key j down
        bind-key k up
        bind-key l open
        bind-key h quit
      '';
    };
    nix-index = {
      enable = true;
      # enableFishIntegration = true;
      enableZshIntegration = false;
      enableBashIntegration = false;
    };
    fish.enable = true;
    fish = {
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
        fzf_configure_bindings --directory=\cf
      '';
      shellAliases = {
        asd = "lazygit";
        e = "nvim";
        zj = "zellij";
        q = "exit";
        az = "yazi";
        cdtmp = "cd (mktemp -d)";
      };
      plugins = [
        # Enable a plugin (here grc for colorized command output) from nixpkgs
        {
          name = "grc";
          src = pkgs.fishPlugins.grc.src;
        }
        {
          name = "fzf-fish";
          src = pkgs.fishPlugins.fzf-fish.src;
        }
      ];
    };
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
    nushell = {
      enable = true;
      configFile.source = ../../config/nushell/config.nu;
      envFile.source = ../../config/nushell/env.nu;
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

  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
