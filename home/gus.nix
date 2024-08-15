{
  pkgs,
  lib,
  ...
}: {
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
    };
  };

  catppuccin.flavor = "mocha";
  catppuccin.enable = true;
  catppuccin.accent = "rosewater";
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

  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
