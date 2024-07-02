{inputs, ...}: {
  imports = [
    inputs.treefmt-nix.flakeModule
  ];

  perSystem = {
    treefmt.config = {
      projectRootFile = "flake.nix";
      programs.black.enable = true;
      programs.alejandra.enable = true;
      programs.prettier = {
        enable = true;
        excludes = ["*.yaml" "*.lock" "config/**/lazy-lock.json" "*.yml"];
      };
      programs.stylua.enable = true;
      programs.shfmt = {
        enable = true;
        indent_size = 0;
      };
    };
  };
}
