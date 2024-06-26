{
  config,
  inputs,
  pkgs,
  ...
}: {
  programs.yazi = {
    package = inputs.yazi.packages.${pkgs.system}.default;
    enable = true;
    enableNushellIntegration = true;
    settings = {
      manager = {
        ratio = [1 3 3];
        sort_by = "natural";
        sort_reverse = false;
        sort_dir_first = true;
        show_hidden = true;
        show_symlink = true;
        linemode = "size";
      };
      preview = {
        cache_dir = "${config.xdg.cacheHome}";
        max_height = 900;
        max_width = 600;
      };
    };
  };
}
