{...}: {
  imports = [
    ./core.nix
    ./nvidia.nix
    ./package.nix
    ./desktop
    ./fonts.nix
    ./nixconfig.nix
    ./sops.nix
    ./network.nix
    ./virtual.nix
    ./boot.nix
  ];
}
