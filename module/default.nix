{inputs, ...}: {
  imports = [
    inputs.daeuniverse.nixosModules.dae
    inputs.daeuniverse.nixosModules.daed
    inputs.nur.nixosModules.nur
    inputs.home-manager.nixosModules.home-manager
  ];
}
