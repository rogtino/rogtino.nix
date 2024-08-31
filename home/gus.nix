{pkgs, ...}: {
  home = {
    username = "gus";
    homeDirectory = "/home/gus";

    stateVersion = "23.11";
  };
  xdg = {
    enable = true;
    configFile = {
      "hypr/scripts" = {
        source = ./desktop/scripts;
      };
      "wezterm" = {
        source = ../config/wezterm;
      };
    };
  };
  catppuccin = {
    flavor = "mocha";
    enable = true;
    accent = "rosewater";
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
    kitty = {
      enable = true;
      font.size = 16;
      font.name = "monospace";
    };
    foot = {
      enable = true;
      settings = {
        main = {
          font = "monospace:size=16";
        };
      };
    };
    zathura = {
      enable = true;
      options = {
        window-title-basename = "true";
        selection-clipboard = "clipboard";
        adjust-open = "width";
      };
    };
    alacritty = {
      enable = true;
      settings = {
        font = {
          size = 15;
        };
      };
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  dconf = {
    enable = true;
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        blur-my-shell.extensionUuid
        gsconnect.extensionUuid
        kimpanel.extensionUuid
        system-monitor.extensionUuid
        window-list.extensionUuid
        workspace-indicator.extensionUuid
      ];
    };
  };
}
