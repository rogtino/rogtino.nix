{...}: {
  imports = [
    ./system.nix
    #BUG:https://github.com/hyprwm/Hyprland/issues/5295
    # flickering!!
    ./nvidia.nix
    ./package.nix
    ./nixconfig.nix
    ./hardware-configuration.nix
  ];
}
