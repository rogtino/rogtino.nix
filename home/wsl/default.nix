{inputs, ...}: {
  # home-manager.users.gus = import ./home.nix {inherit inputs lib pkgs;};
  home-manager = {
    backupFileExtension = "backup";
    useUserPackages = true;
    useGlobalPkgs = true;
    users.gus.imports = [
      ../devtools.nix
      inputs.nix-index-database.hmModules.nix-index
      {
        home.username = "gus";
        home.homeDirectory = "/home/gus";
        home.stateVersion = "23.11";
        programs.home-manager.enable = true;
      }
    ];
    extraSpecialArgs = {inherit inputs;};
  };
}
