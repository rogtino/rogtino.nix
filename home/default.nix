{inputs, ...}: {
  # home-manager.users.gus = import ./home.nix {inherit inputs lib pkgs;};
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.gus.imports = [
      ./gus.nix
      inputs.nix-index-database.hmModules.nix-index
      inputs.hyprlock.homeManagerModules.default
      inputs.hypridle.homeManagerModules.default
      inputs.ags.homeManagerModules.default
    ];
    extraSpecialArgs = {inherit inputs;};
  };
}
