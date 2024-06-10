{
  description = "dark art";

  outputs = {
    self,
    nixpkgs,
    daeuniverse,
    home-manager,
    nur,
    ...
  } @ inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        ./pre-commit-hooks.nix
        ./treefmt.nix
      ];
      systems = ["x86_64-linux"];
      flake = {
        nixosConfigurations.art = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./system
            ./home
            ./module
            ./overlay
          ];
          specialArgs = {inherit inputs;};
        };
        nixosConfigurations.none = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./system/none
            ./home/none
            ./module/none
          ];
          specialArgs = {inherit inputs;};
        };
      };
      perSystem = {
        config,
        pkgs,
        system,
        ...
      }: {
        _module.args.pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          config.permittedInsecurePackages = [
            "openssl"
          ];
        };
        devShells.default = pkgs.mkShell {
          name = "rogtino";
          inputsFrom = [config.treefmt.build.devShell];
          packages = with pkgs; [
            git
            vim
            sops
          ];
          shellHook = ''
            ${config.pre-commit.installationScript}
          '';
        };
      };
    };
  inputs = {
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    #NOTE:https://flake.parts/best-practices-for-module-writing
    flake-parts.url = "github:hercules-ci/flake-parts";
    #NOTE:https://github.com/hyprwm/hyprpaper/issues/88
    # can't load image instantly
    # hyprpaper.url = "github:hyprwm/hyprpaper";
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    daeuniverse.url = "github:daeuniverse/flake.nix";
    hyprland = {
      url = "https://github.com/hyprwm/Hyprland";
      type = "git";
      submodules = true;
    };
    # flake-root.url = "github:srid/flake-root";
    home-manager.url = "github:nix-community/home-manager";
    ags.url = "github:Aylur/ags";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
}
