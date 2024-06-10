{inputs, ...}: {
  imports = [
    inputs.pre-commit-hooks.flakeModule
  ];

  perSystem = {
    pre-commit = {
      check.enable = true;
      settings = {
        excludes = ["flake.lock" "lazy-lock.json"];
        hooks = {
          alejandra.enable = true;
          nil.enable = true;
          commitizen.enable = true;
          black.enable = true;
          shfmt.enable = true;
          stylua.enable = true;
          lua-ls.enable = true;
          prettier = {
            enable = true;
            excludes = [".yaml" ".lock" ".yml"];
          };
        };
      };
    };
  };
}
