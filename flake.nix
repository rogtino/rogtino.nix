{
  description = "dark art";

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
    sops-nix.url = "github:Mic92/sops-nix";
    nur.url = "github:nix-community/NUR";
    daeuniverse.url = "github:daeuniverse/flake.nix";
    hyprland.url = "github:hyprwm/Hyprland";
    # flake-root.url = "github:srid/flake-root";
    home-manager.url = "github:nix-community/home-manager";
    ags.url = "github:Aylur/ags";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    daeuniverse,
    home-manager,
    nur,
    sops-nix,
    ...
  } @ inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        inputs.pre-commit-hooks.flakeModule
        inputs.treefmt-nix.flakeModule
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
          specialArgs = {inherit nixpkgs daeuniverse inputs;};
        };
        nixosConfigurations.none = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./system/none
            ./home/none
            ./module/none
          ];
          specialArgs = {inherit nixpkgs inputs;};
        };
      };
      perSystem = {
        config,
        pkgs,
        system,
        ...
      }: {
        pre-commit = {
          check.enable = true;

          settings = {
            excludes = ["flake.lock" "lazy.lock"];
            hooks = {
              alejandra.enable = true;
              nil.enable = true;
              commitizen.enable = true;
              black.enable = true;
              shfmt.enable = true;
              stylua.enable = true;
              lua-ls.enable = true;
            };
          };
        };
        treefmt.config = {
          projectRootFile = "flake.nix";
          programs.black.enable = true;
          programs.alejandra.enable = true;
          # programs.prettier.enable = true;
          programs.stylua.enable = true;
          programs.shfmt = {
            enable = true;
            indent_size = 0;
          };
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
}
