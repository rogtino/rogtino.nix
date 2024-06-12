{pkgs, ...}: {
  home.username = "gus";
  home.homeDirectory = "/home/gus";
  xdg = {
    enable = true;
    configFile = {
      "hypr/scripts" = {
        source = ./desktop/scripts;
      };
      "wezterm" = {
        source = ../config/wezterm;
      };
      "waybar" = {
        source = ../config/waybar;
      };
    };
  };

  services.mako = {
    enable = true;
    icons = true;
    maxIconSize = 64;
    maxVisible = 3;
    defaultTimeout = 5000;
    ignoreTimeout = true;
    anchor = "top-right";
    output = "eDP-1";
    font = "Fira Code 10";
    padding = "10";
    width = 270;
    height = 100;
    margin = "18,21,0";
    backgroundColor = "#1e1e2e";
    textColor = "#a9b1d6";
    borderColor = "#89b4fa";
    borderRadius = 12;
    progressColor = "over #313244";
    extraConfig = ''
      [urgency=low]
      text-color=#36CC8B
      default-timeout=5000

      [urgency=normal]
      text-color=#de8f78
      default-timeout=10000

      [urgency=critical]
      text-color=#FF5369
      default-timeout=0

    '';
  };

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
    kitty.enable = true;
    foot = {
      enable = true;
      settings = {
        main = {
          font = "monospace:size=16";
        };
        colors = {
          background = "0d1117";
          foreground = "c9d1d9";
          regular0 = "484f58";
          regular1 = "ff7b72";
          regular2 = "58a6ff";
          regular3 = "d29922";
          regular4 = "58a6ff";
          regular5 = "bc8cff";
          regular6 = "39c5cf";
          regular7 = "b1bac4";
          bright0 = "6e7681";
          bright1 = "ffa198";
          bright2 = "79c0ff";
          bright3 = "e3b341";
          bright4 = "79c0ff";
          bright5 = "d2a8ff";
          bright6 = "56d4dd";
          bright7 = "ffffff";
        };
      };
    };
    zathura = {
      enable = true;
      options = {
        window-title-basename = "true";
        selection-clipboard = "clipboard";
        adjust-open = "width";
        recolor = true;
        notification-error-bg = "#ff5555";
        notification-error-fg = "#f8f8f2";
        notification-warning-bg = "#ffb86c";
        notification-warning-fg = "#44475a";
        notification-bg = "#282a36";
        notification-fg = "#f8f8f2";
        completion-bg = "#282a36";
        completion-fg = "#6272a4";
        completion-group-bg = "#282a36";
        completion-group-fg = "#6272a4";
        completion-highlight-bg = "#44475a";
        completion-highlight-fg = "#f8f8f2";
        index-bg = "#282a36";
        index-fg = "#f8f8f2";
        index-active-bg = "#44475a";
        index-active-fg = "#f8f8f2";
        inputbar-bg = "#282a36";
        inputbar-fg = "#f8f8f2";
        statusbar-bg = "#282a36";
        statusbar-fg = "#f8f8f2";
        highlight-color = "#ffb86c";
        highlight-active-color = "#ff79c6";
        default-bg = "#282a36";
        default-fg = "#f8f8f2";
        render-loading = true;
        render-loading-fg = "#282a36";
        render-loading-bg = "#f8f8f2";
        recolor-lightcolor = "#282a36";
        recolor-darkcolor = "#f8f8f2";
      };
    };
    alacritty = {
      enable = true;
      settings = {
        colors.bright = {
          black = "#393939";
          blue = "#33b1ff";
          cyan = "#3ddbd9";
          green = "#42be65";
          magenta = "#ff7eb6";
          red = "#ee5396";
          white = "#ffffff";
          yellow = "#ffe97b";
        };
        colors.primary = {
          background = "#161616";
          foreground = "#ffffff";
        };
        colors.search.matches = {
          background = "#ee5396";
          foreground = "CellBackground";
        };
        font = {
          size = 15;
        };
        colors.normal = {
          black = "#262626";
          blue = "#33b1ff";
          cyan = "#3ddbd9";
          green = "#42be65";
          magenta = "#ff7eb6";
          red = "#ee5396";
          white = "#dde1e6";
          yellow = "#ffe97b";
        };
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
