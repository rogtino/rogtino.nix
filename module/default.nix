{inputs, ...}: {
  imports = [
    inputs.daeuniverse.nixosModules.dae
    inputs.daeuniverse.nixosModules.daed
    inputs.lix-module.nixosModules.default
    inputs.nur.nixosModules.nur
    inputs.sops-nix.nixosModules.sops
    inputs.catppuccin.nixosModules.catppuccin
    inputs.home-manager.nixosModules.home-manager
    inputs.niri.nixosModules.niri
  ];
  programs.niri.enable = true;
}
