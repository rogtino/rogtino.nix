{...}: {
  imports = [
    ./system.nix
    ./nvidia.nix
    ./package.nix
    ./nixconfig.nix
    ./hardware-configuration.nix
  ];
}
