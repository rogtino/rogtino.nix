{
  pkgs,
  inputs,
  ...
}
: let
  hyprland-nvidia-session = pkgs.writeTextFile {
    name = "hyprland-nvidia.desktop";
    destination = "/share/wayland-sessions/hyprland-nvidia.desktop";
    text = ''
      [Desktop Entry]
      Comment=An intelligent dynamic tiling Wayland compositor (with more nvidia)
      Exec=nvidia-offload Hyprland
      Name=Hyprland-nvidia
      Type=Application
      Version=1.4
    '';
    checkPhase = ''${pkgs.buildPackages.desktop-file-utils}/bin/desktop-file-validate "$target"'';
    derivationArgs = {passthru.providedSessions = ["hyprland-nvidia"];};
  };
in {
  services = {
    displayManager.sessionPackages = [hyprland-nvidia-session];
  };
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

    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  security.pam.services.hyprlock = {};
}
