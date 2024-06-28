{inputs, ...}: {
  # home-manager.users.gus = import ./home.nix {inherit inputs lib pkgs;};
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "default";
    users.gus.imports = [
      ./gus.nix
      ./desktop
      ./tools.nix
      ./devtools.nix
      ./yazi.nix
      inputs.nix-index-database.hmModules.nix-index
      inputs.ags.homeManagerModules.default
      inputs.catppuccin.homeManagerModules.catppuccin
    ];
    extraSpecialArgs = {inherit inputs;};
  };
}
