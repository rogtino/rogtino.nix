{pkgs, ...}
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
}
