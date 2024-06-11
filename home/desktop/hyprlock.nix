{...}: {
  programs.hyprlock = {
    enable = true;
    settings = {
      background = let
        wallpaperPath = "/home/gus/Pictures/wallpapers/b29f2454efdc4ccb84ce2feb7fa24b83.jpg";
      in [
        {
          monitor = "eDP-1";
          path = wallpaperPath;
        }
      ];
      general = {
        no_fade_in = false;
      };
      input-fields = [
        {
          monitor = "eDP-1";

          size = "300, 50";
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
      labels = [
        {
          monitor = "eDP-1";
          text = "Hi, $USER";
          color = "rgb(1e1e2e)";
          valign = "center";
          halign = "center";
          font_size = 40;
        }
        {
          monitor = "eDP-1";
          text = "$TIME";
          color = "rgb(1e1e2e)";
          font_size = 30;
          position = {
            x = 0;
            y = 140;
          };
          valign = "center";
          halign = "center";
        }
      ];
    };
  };
}
