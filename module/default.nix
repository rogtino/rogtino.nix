{inputs, ...}: {
  imports = [
    inputs.daeuniverse.nixosModules.dae
    inputs.daeuniverse.nixosModules.daed
    inputs.sops-nix.nixosModules.sops
    inputs.nur.nixosModules.nur
    inputs.home-manager.nixosModules.home-manager
  ];
}
