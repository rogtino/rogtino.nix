{...}: {
  imports = [
    ./polkit-agent.nix
    ./guix.nix
    ./power.nix
  ];
  services.gvfs.enable = true;
}
