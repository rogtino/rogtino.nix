{inputs, ...}: {
  # home-manager.users.gus = import ./home.nix {inherit inputs lib pkgs;};
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.gus.imports = [
      ./gus.nix
    ];
    extraSpecialArgs = {inherit inputs;};
  };
}
