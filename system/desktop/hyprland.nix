{
  pkgs,
  inputs,
  ...
}
: {
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  };

  xdg.portal = {
    enable = true;
    # xdgOpenUsePortal = true;
    config = {
      common.default = ["gtk"];
      hyprland.default = ["gtk" "hyprland"];
    };

    # extraPortals = [
    #   pkgs.xdg-desktop-portal-gtk
    # ];
  };

  security.pam.services.hyprlock = {};
}
