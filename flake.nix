{
  description = "dark art";

  nixConfig = {
    # substituers will be appended to the default substituters when fetching packages
    extra-substituters = [
      "https://daeuniverse.cachix.org"
      "https://nix-community.cachix.org"
      "https://numtide.cachix.org"
      "https://hyprland.cachix.org"
      "https://yazi.cachix.org"
      # "https://cuda-maintainers.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      "daeuniverse.cachix.org-1:8hRIzkQmAKxeuYY3c/W1I7QbZimYphiPX/E7epYNTeM="
      "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
      # "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    ];
  };
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
        nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./system/wsl
            ./home/wsl
            ./module/wsl
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
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    catppuccin.url = "github:catppuccin/nix";
    yazi.url = "github:sxyazi/yazi";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };
}
