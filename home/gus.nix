{
  inputs,
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
  # home.pointerCursor = {
  #   package = pkgs.bibata-cursors;
  #   name = "Bibata-Modern-Classic";
  #   gtk.enable = true;
  # };
  # gtk = {
  #   enable = true;
  #   iconTheme = {
  #     package = pkgs.papirus-icon-theme;
  #     name = "Papirus-Dark";
  #   };
  #   theme = {
  #     package = pkgs.orchis-theme;
  #     name = "Orchis-Dark";
  #   };
  #   cursorTheme = {
  #     package = pkgs.bibata-cursors;
  #     name = "Bibata-Modern-Classic";
  #   };
  # };
  #
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
      "hypr" = {
        #source = ../config/hypr/hyprland.conf;
        source = link "/home/gus/rogtino.nix/config/hypr";
      };
      "wezterm" = {
        source = ../config/wezterm;
      };
      "waybar" = {
        source = ../config/waybar;
      };
      "zathura" = {
        source = ../config/zathura;
      };
      "alacritty" = {
        source = ../config/alacritty;
      };
      # "bgscripts" = {
      #   source = ../config/bgscripts;
      # };
      # BUG:cann't use
      # https://github.com/nushell/nushell/issues/10100
      "nushell" = {
        source = config.lib.file.mkOutOfStoreSymlink "/home/gus/rogtino.nix/config/nushell";
      };
      "zellij" = {
        source = ../config/zellij;
      };
    };
  };

  # 直接将当前文件夹的配置文件，链接到 Home 目录下的指定位置
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # 递归将某个文件夹中的文件，链接到 Home 目录下的指定位置
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # 递归整个文件夹
  #   executable = true;  # 将其中所有文件添加「执行」权限
  # };

  # 直接以 text 的方式，在 nix 配置文件中硬编码文件内容
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # 设置鼠标指针大小以及字体 DPI（适用于 4K 显示器）
  #xresources.properties = {
  #  "Xcursor.size" = 16;
  #  "Xft.dpi" = 172;
  #};

  # 通过 home.packages 安装一些常用的软件
  # 这些软件将仅在当前用户下可用，不会影响系统级别的配置
  # 建议将所有 GUI 软件，以及与 OS 关系不大的 CLI 软件，都通过 home.packages 安装
  home.packages = with pkgs;
    [
      bilibili
      # qq
      firefox
      google-chrome
      # nix related
      #
      # it provides the command `nom` works just like `nix`
      # with more details log output
      nix-output-monitor
    ]
    ++ [
      #BUG:seems like not being used
      inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
    ]
    ++ shtools
    ++ tools
    ++ lsp
    ++ formatter;

  services.mako = {
    enable = true;
    icons = true;
    maxIconSize = 64;
    maxVisible = 3;
    defaultTimeout = 5000;
    ignoreTimeout = true;
    anchor = "top-right";
    output = "eDP-1";
    font = "Maple Mono SC NF 12";
    padding = "6";
    margin = "18,21,0";
    backgroundColor = "#1a1b26";
    textColor = "#a9b1d6";
    borderColor = "#2ac3de";
    progressColor = "over #313244";
  };

  #services.hypridle = {
  #  enable = true;
  #  settings = {
  #    general = {
  #      lockCmd = lib.getExe config.programs.hyprlock.package;
  #      beforeSleepCmd = "${pkgs.systemd}/bin/loginctl lock-session";
  #    };
  #    listeners = [
  #      {
  #        timeout = 295;
  #        onTimeout = "${pkgs.libnotify}/bin/notify-send 'Locking in 5 seconds' -t 5000";
  #      }
  #      {
  #        timeout = 300;
  #        onTimeout = "${lib.getExe config.programs.hyprlock.package}";
  #      }
  #      {
  #        timeout = 600;
  #        onTimeout = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl dispatch dpms off";
  #        onResume = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl dispatch dpms on";
  #      }
  #    ];
  #  };
  #};
  programs = {
    ags = {
      enable = true;

      # null or path, leave as null if you don't want hm to manage the config
      # configDir = ../ags;

      # additional packages to add to gjs's runtime
      extraPackages = with pkgs; [
        gtksourceview
        webkitgtk
        accountsservice
      ];
    };
    # command-not-found.enable = true;
    #hyprlock = {
    #  enable = true;
    #  settings = {
    #    backgrounds = let
    #      wallpaperPath = "/home/gus/Pictures/wallpapers/03366b011ece465696cfad1e87b2ee6e.png";
    #    in [
    #      {
    #        monitor = "eDP-1";
    #        path = wallpaperPath;
    #      }
    #    ];
    #    general = {
    #      grace = 5;
    #      no_fade_in = false;
    #    };
    #    input-fields = [
    #      {
    #        monitor = "eDP-1";
    #        size = {
    #          width = 300;
    #          height = 50;
    #        };
    #        outline_thickness = 2;

    #        outer_color = "rgb(f5c2e7)";
    #        inner_color = "rgb(1e1e2e)";
    #        font_color = "rgb(cdd6f4)";
    #        placeholder_text = ''
    #          <span foreground="##cdd6f4">Password...</span>
    #        '';
    #        fade_on_empty = false;
    #        dots_spacing = 0.3;
    #        dots_center = true;
    #      }
    #    ];
    #    labels = [
    #      {
    #        monitor = "eDP-1";
    #        text = "Hi, $USER";
    #        color = "rgb(1e1e2e)";
    #        valign = "center";
    #        halign = "center";
    #        font_size = 40;
    #      }
    #      {
    #        monitor = "eDP-1";
    #        text = "$TIME";
    #        color = "rgb(1e1e2e)";
    #        font_size = 30;
    #        position = {
    #          x = 0;
    #          y = 140;
    #        };
    #        valign = "center";
    #        halign = "center";
    #      }
    #    ];
    #  };
    #};

    # nix-index = {
    #   enable = true;
    #   # enableFishIntegration = false;
    #   enableZshIntegration = false;
    #   enableBashIntegration = false;
    # };
    fish.enable = true;
    newsboat = {
      enable = true;
      maxItems = 50;
      autoReload = true;
      urls = [
        {url = "https://www.ruanyifeng.com/blog/atom.xml";}
        {url = "https://v2ex.com/index.xml";}
        {url = "https://rsshub.app/zhihu/hotlist";}
        {url = "https://36kr.com/feed";}
        {url = "https://cert.360.cn/daily/feed";}
      ];
      extraConfig = ''
        # externel browser
        browser "w3m %u"
        macro m set browser "mpv %u"; open-in-browser ; set browser "w3m %u"
        macro l set browser "firefox %u"; open-in-browser ; set browser "w3m %u"
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
    kitty.enable = true;
    alacritty = {
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
    # nushell = {
    #   enable = true;
    #   configFile.source = ../config/nushell/config.nu;
    #   envFile.source = ../config/nushell/env.nu;
    # };
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

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
