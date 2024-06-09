{inputs, ...}: {
  # home-manager.users.gus = import ./home.nix {inherit inputs lib pkgs;};
  home-manager = {
    backupFileExtension = "backup";
    useUserPackages = true;
    useGlobalPkgs = true;
    users.gus.imports = [
      ./gus.nix
      inputs.nix-index-database.hmModules.nix-index
    ];
    extraSpecialArgs = {inherit inputs;};
  };
}
