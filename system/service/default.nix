{pkgs, ...}: {
  imports = [
    ./polkit-agent.nix
    # ./guix.nix
    ./power.nix
  ];
  services = {
    gvfs.enable = true;
    displayManager.defaultSession = "hyprland";
    displayManager.sddm = {
      package = pkgs.kdePackages.sddm;
      catppuccin = {
        enable = true;
        fontSize = "18";
        font = "Martian Mono";
        background = "/home/gus/Pictures/wallpapers/4d5b121d880511ebb6edd017c2d2eca2.png";
      };
      enable = true;
    };
  };
}
