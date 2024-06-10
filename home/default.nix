{inputs, ...}: {
  # home-manager.users.gus = import ./home.nix {inherit inputs lib pkgs;};
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "default";
    users.gus.imports = [
      ./gus.nix
      inputs.nix-index-database.hmModules.nix-index
      inputs.ags.homeManagerModules.default
    ];
    extraSpecialArgs = {inherit inputs;};
  };
}
