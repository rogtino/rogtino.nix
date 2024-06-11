{...}: {
  imports = [
    ./hardware-configuration.nix
    ../core.nix
    ../sops.nix
    ../nixconfig.nix
  ];
}
