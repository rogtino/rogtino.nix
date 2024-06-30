{pkgs, ...}: {
  imports = [
    ./polkit-agent.nix
    ./guix.nix
    ./power.nix
  ];
  services.gvfs.enable = true;
  services.displayManager.sddm = {
    package = pkgs.kdePackages.sddm;
    catppuccin.enable = true;
    catppuccin.fontSize = "18";
    catppuccin.font = "Martian Mono";
    catppuccin.background = "/home/gus/Pictures/wallpapers/190e4e36f72345799583c21201d06b2a.png";
    enable = true;
  };
}
