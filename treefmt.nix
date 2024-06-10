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
        excludes = ["*.yaml" "*.lock" "lazy-lock.json"];
      };
      programs.stylua.enable = true;
      programs.shfmt = {
        enable = true;
        indent_size = 0;
      };
    };
  };
}
