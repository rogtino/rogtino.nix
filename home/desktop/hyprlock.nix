{...}: {
  programs.hyprlock = {
    enable = true;
    settings = {
      background = let
        wallpaperPath = "/home/gus/Pictures/wallpapers/7e500ca1145b45e695bdadb394cc4be3.jpg";
      in [
        {
          monitor = "eDP-1";
          path = wallpaperPath;
        }
      ];
      general = {
        no_fade_in = false;
        grace = 0;
        disable_loading_bar = true;
      };
      input-field = [
        {
          outline_thickness = 2;
          outer_color = "rgb(f5c2e7)";
          inner_color = "rgb(1e1e2e)";
          font_color = "rgb(cdd6f4)";
          placeholder_text = ''
            <span foreground="##cdd6f4">Password...</span>
          '';
          fade_on_empty = false;
          dots_spacing = 0.3;
          dots_center = true;
        }
      ];
      label = [
        {
          text = "Hi, $USER";
          color = "rgb(c0caf5)";
          valign = "center";
          halign = "center";
          font_size = 70;
          position = "0, 250";
        }
        {
          text = "$TIME";
          color = "rgb(c0caf5)";
          font_size = 50;
          position = "0, 100";
          valign = "center";
          halign = "center";
        }
      ];
    };
  };
}
