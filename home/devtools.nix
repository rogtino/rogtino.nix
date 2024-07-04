{
  pkgs,
  config,
  inputs,
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
    selene
    gopls
    emmet-language-server
    nodePackages."@tailwindcss/language-server"
    pyright
    sumneko-lua-language-server
    rust-analyzer
    cmake-language-server
    ruff
    bash-language-server
    # solc
  ];
  formatter = [
    taplo
    rustfmt
    google-java-format
    alejandra
    cmake-format
    shfmt
    stylua
    black
    biome
    fnlfmt
    typstfmt
  ];
  tools = [
    cowsay
    # manix
    htop-vim
    fastfetch
    commitizen
    nodePackages.conventional-changelog-cli
    exiftool
    tealdeer
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
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor
  ];
  inherit (config.lib.file) mkOutOfStoreSymlink;
  browser = ["firefox"];
  imageViewer = ["imv"];
  videoPlayer = ["mpv"];

  xdgAssociations = type: program: list:
    builtins.listToAttrs (map (e: {
        name = "${type}/${e}";
        value = program;
      })
      list);

  image = xdgAssociations "image" imageViewer ["png" "svg" "jpeg"];
  video = xdgAssociations "video" videoPlayer ["mp4" "avi" "mkv"];
  browserTypes =
    (xdgAssociations "application" browser [
      "json"
      "x-extension-htm"
      "x-extension-html"
      "x-extension-shtml"
      "x-extension-xht"
      "x-extension-xhtml"
    ])
    // (xdgAssociations "x-scheme-handler" browser [
      "about"
      "ftp"
      "http"
      "https"
      "unknown"
    ]);

  # XDG MIME types
  associations = builtins.mapAttrs (_: v: (map (e: "${e}.desktop") v)) ({
      "application/pdf" = ["org.pwmt.zathura"];
      "application/epub+zip" = ["org.pwmt.zathura"];
      "text/html" = browser;
      "text/plain" = ["nvim"];
      "x-scheme-handler/chrome" = ["chromium-browser"];
      "inode/directory" = ["yazi"];
      "image/gif" = ["mpv"];
    }
    // image
    // video
    // browserTypes);
in {
  programs = {
    fish.enable = true;
    git = {
      enable = true;
      userName = "rogtino";
      userEmail = "rogtino@proton.me";
      extraConfig = {
        # http.postBuffer = "4096M";
        http.version = "HTTP/1.1";
        credential = {
          helper = "store";
        };
      };
      ignores = [".direnv" "node_modules"];
    };
    bat.enable = true;
    gitui.enable = true;
    imv.enable = true;
    zellij.enable = true;
    btop = {
      enable = true;
      settings = {
        vim_keys = true;
      };
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

    mimeApps = {
      enable = true;
      defaultApplications = associations;
    };
    configFile = {
      "zellij/layouts/default.kdl".text = ''
        layout {
            default_tab_template {
                children
                pane size=1 borderless=true {
                    plugin location="file:${inputs.zjstatus.packages.x86_64-linux.default}/bin/zjstatus.wasm" {
                        format_left   "{mode} #[fg=#89B4FA,bold]{session}"
                        format_center "{tabs}"
                        format_right  "{command_git_branch} {datetime}"
                        format_space  ""

                        border_enabled  "false"
                        border_char     "─"
                        border_format   "#[fg=#FFAAFF]{char}"
                        border_position "top"

                        hide_frame_for_single_pane "true"

                        mode_normal    "#[fg=#54DB8C]{name}"
                        mode_tab       "#[fg=#ffc387]{name}"
                        mode_scroll    "#[fg=#FF5587]{name}"
                        mode_search    "#[fg=#AF5587]{name}"
                        mode_pane      "#[fg=#FF7846]{name}"
                        mode_locked    "#[fg=#FF0A32]{name}"

                        tab_normal   "#[fg=#6C7086] {name} "
                        tab_active   "#[fg=#FF99B2,bold] {name} "
                        tab_sync_indicator       "<> "
                        tab_fullscreen_indicator "[] "
                        tab_floating_indicator   "⬚ "

                        command_git_branch_command     "git rev-parse --abbrev-ref HEAD"
                        command_git_branch_format      "#[fg=blue] {stdout} "
                        command_git_branch_interval    "10"
                        command_git_branch_rendermode  "static"

                        datetime        "#[fg=#B27086,bold] {format} "
                        datetime_format "%A, %b %d"
                        datetime_timezone "Asia/Shanghai"
                    }
                }
            }
        }
      '';
      "nvim" = {
        source = mkOutOfStoreSymlink "/home/gus/rogtino.nix/config/nvim";
      };
      "nushell" = {
        source = mkOutOfStoreSymlink "/home/gus/rogtino.nix/config/nushell";
      };
      "emacs/init.el" = {
        source = mkOutOfStoreSymlink "/home/gus/rogtino.nix/config/emacs/init.el";
      };
      "zellij/config.kdl".source = mkOutOfStoreSymlink "/home/gus/rogtino.nix/config/zellij/config.kdl";
      "guix" = {
        source = mkOutOfStoreSymlink "/home/gus/rogtino.nix/config/guix";
      };
      "ags" = {
        source = mkOutOfStoreSymlink "/home/gus/rogtino.nix/config/ags";
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
