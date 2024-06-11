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
      "zathura" = {
        source = ../config/zathura;
      };
      "alacritty" = {
        source = ../config/alacritty;
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
    font = "Fira Code";
    padding = "6";
    margin = "18,21,0";
    backgroundColor = "#1a1b26";
    textColor = "#a9b1d6";
    borderColor = "#2ac3de";
    progressColor = "over #313244";
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
    alacritty = {
      enable = true;
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
