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
    vscode-langservers-extracted
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
      "guix" = {
        source = mkOutOfStoreSymlink "/home/gus/rogtino.nix/config/guix";
      };
      "ags" = {
        source = mkOutOfStoreSymlink "/home/gus/rogtino.nix/config/ags";
      };
    };
  };
  programs.bat = {
    enable = true;
    config = {
      theme = "mocha";
    };
    themes = {
      mocha = {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "d714cc1d358ea51bfc02550dabab693f70cccea0";
          sha256 = "Q5B4NDrfCIK3UAMs94vdXnR42k4AXCqZz6sRn8bzmf4=";
        };
        file = "themes/Catppuccin Mocha.tmTheme";
      };
    };
  };

  programs.yazi = {
    enable = true;
    theme = {
      filetype = {
        rules = [
          {
            mime = "image/*";
            fg = "#94e2d5";
          }
          {
            mime = "video/*";
            fg = "#f9e2af";
          }
          {
            mime = "audio/*";
            fg = "#f9e2af";
          }
          {
            mime = "application/zip";
            fg = "#f5c2e7";
          }
          {
            mime = "application/gzip";
            fg = "#f5c2e7";
          }
          {
            mime = "application/x-tar";
            fg = "#f5c2e7";
          }
          {
            mime = "application/x-bzip";
            fg = "#f5c2e7";
          }
          {
            mime = "application/x-bzip2";
            fg = "#f5c2e7";
          }
          {
            mime = "application/x-7z-compressed";
            fg = "#f5c2e7";
          }
          {
            mime = "application/x-rar";
            fg = "#f5c2e7";
          }
          {
            name = "*";
            fg = "#cdd6f4";
          }
          {
            name = "*/";
            fg = "#89b4fa";
          }
        ];
      };
      help = {
        on = {fg = "#f5c2e7";};
        exec = {fg = "#94e2d5";};
        desc = {fg = "#9399b2";};
        hovered = {
          bg = "#585b70";
          bold = true;
        };
        footer = {
          fg = "#45475a";
          bg = "#cdd6f4";
        };
      };
      which = {
        mask = {bg = "#313244";};
        cand = {fg = "#94e2d5";};
        rest = {fg = "#9399b2";};
        desc = {fg = "#f5c2e7";};
        separator = "  ";
        separator_style = {fg = "#585b70";};
      };
      tasks = {
        border = {fg = "#89b4fa";};
        title = {};
        hovered = {underline = true;};
      };
      select = {
        border = {fg = "#89b4fa";};
        active = {fg = "#f5c2e7";};
        inactive = {};
      };
      input = {
        border = {fg = "#89b4fa";};
        title = {};
        value = {};
        selected = {reversed = true;};
      };
      status = {
        separator_open = "";
        separator_close = "";
        separator_style = {
          fg = "#45475a";
          bg = "#45475a";
        };
        mode_normal = {
          fg = "#1e1e2e";
          bg = "#89b4fa";
          bold = true;
        };
        mode_select = {
          fg = "#1e1e2e";
          bg = "#a6e3a1";
          bold = true;
        };
        mode_unset = {
          fg = "#1e1e2e";
          bg = "#f2cdcd";
          bold = true;
        };
        progress_label = {
          fg = "#ffffff";
          bold = true;
        };
        progress_normal = {
          fg = "#89b4fa";
          bg = "#45475a";
        };
        progress_error = {
          fg = "#f38ba8";
          bg = "#45475a";
        };
        permissions_t = {fg = "#89b4fa";};
        permissions_r = {fg = "#f9e2af";};
        permissions_w = {fg = "#f38ba8";};
        permissions_x = {fg = "#a6e3a1";};
        permissions_s = {fg = "#7f849c";};
      };
      manager = {
        cwd = {fg = "#94e2d5";};
        hovered = {
          fg = "#1e1e2e";
          bg = "#89b4fa";
        };
        preview_hovered = {underline = true;};
        find_keyword = {
          fg = "#f9e2af";
          italic = true;
        };
        find_position = {
          fg = "#f5c2e7";
          bg = "reset";
          italic = true;
        };
        marker_copied = {
          fg = "#a6e3a1";
          bg = "#a6e3a1";
        };
        marker_cut = {
          fg = "#f38ba8";
          bg = "#f38ba8";
        };
        marker_selected = {
          fg = "#89b4fa";
          bg = "#89b4fa";
        };
        tab_active = {
          fg = "#1e1e2e";
          bg = "#cdd6f4";
        };
        tab_inactive = {
          fg = "#cdd6f4";
          bg = "#45475a";
        };
        tab_width = 1;
        count_copied = {
          fg = "#1e1e2e";
          bg = "#a6e3a1";
        };
        count_cut = {
          fg = "#1e1e2e";
          bg = "#f38ba8";
        };
        count_selected = {
          fg = "#1e1e2e";
          bg = "#89b4fa";
        };
        border_symbol = "│";
        border_style = {fg = "#7f849c";};
        syntect_theme = "~/.config/bat/themes/mocha.tmTheme";
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
