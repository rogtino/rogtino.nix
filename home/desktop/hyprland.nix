{...}: {
  wayland.windowManager.hyprland = {
    enable = true;
    #TODO:add a music mode?
    extraConfig = ''
      bind=$mod,S,submap,resize

      # will start a submap called "resize"
      submap=resize

      # sets repeatable binds for resizing the active window
      binde=,l,resizeactive,10 0
      binde=,h,resizeactive,-10 0
      binde=,k,resizeactive,0 -10
      binde=,j,resizeactive,0 10

      # use reset to go back to the global submap
      bind=,escape,submap,reset

      # will reset the submap, meaning end the current one and return to the global one
      submap=reset

      # will switch to a submap called move
      bind=$mod,M,submap,move

      # will start a submap called "move"
      submap=move
      bind=,escape,submap,reset

      # sets repeatable binds for moving the active window
      bind=,l,movewindow,r
      bind=,h,movewindow,l
      bind=,k,movewindow,u
      bind=,j,movewindow,d

      # will reset the submap, meaning end the current one and return to the global one
      submap=reset

      # will switch to a submap called opacity
      bind=$mod,U,submap,opacity

      # will start a submap called "move"
      submap=opacity
      bind=,escape,submap,reset

      # sets repeatable binds for moving the active window
      bind=,j,exec,~/.config/hypr/scripts/opacity.py d
      bind=,k,exec,~/.config/hypr/scripts/opacity.py i

      # will reset the submap, meaning end the current one and return to the global one
      submap=reset

    '';
    settings = {
      "$mod" = "SUPER";
      monitor = [
        ",preferred,0x0,1"
      ];
      bindle = [
        # volume
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%-"
      ];
      bind = [
        "bind=$mod,W,exec,foot"
        "bind=$mod,Return,exec,alacritty --class termfloat"
        "bind=$mod,F,exec,firefox"
        "bind=$mod,P,exec,grim -g $(slurp)"
        "bind=$mod SHIFT,P,exec,hyprpicker -a"
        "bind=$mod,X,exec,playerctl -p netease-cloud-music play-pause"
        "bind=$mod,N,exec,playerctl -p netease-cloud-music next"
        "bind=$mod,R,exec,ags -t launcher"
        "bind=$mod SHIFT,R,exec,rofi -show run"
        "bind=$mod,A,fullscreen"
        "bind=$mod,Q,killactive"
        "bind=$mod,V,exec,cliphist list | rofi -dmenu| cliphist decode | wl-copy"
        "bind=$mod,C, movetoworkspace, special"
        "bind=$mod,TAB, togglespecialworkspace"
        "bind=$mod,O,exec,~/.config/hypr/scripts/toggle.sh"
        "bind=$mod,I,exec,~/.config/hypr/scripts/scale.sh"
        "bind=$mod, h, movefocus, l"
        "bind=$mod, l, movefocus, r"
        "bind=$mod, k, movefocus, u"
        "bind=$mod, j, movefocus, d"
        "bind=$mod SHIFT,ESCAPE,exit"
        "bind=$mod SHIFT,F,togglefloating"
        "bind=$mod SHIFT,P,exec,hyprlock"
        "bind=$mod SHIFT,H,workspace,-1"
        "bind=$mod SHIFT,L,workspace,+1"
        "bind=$mod,T,togglegroup"
        "bind=$mod SHIFT,K,changegroupactive,f"
        "bind=$mod SHIFT,J,changegroupactive,b"
        "bind=ALT,TAB,changegroupactive,b"
        "bind=CTRL SHIFT,h,resizeactive,-20 0"
        "bind=CTRL SHIFT,l,resizeactive,20 0"
        "bind=CTRL SHIFT,j,resizeactive,0 20"
        "bind=CTRL SHIFT,k,resizeactive,0 -20"
        "bind=$mod SHIFT,a,workspace,1"
        "bind=$mod SHIFT,s,workspace,2"
        "bind=$mod SHIFT,d,workspace,3"
        "bind=$mod SHIFT,c,workspace,4"
        "bind=$mod SHIFT,m,workspace,5"
        "bind=$mod,1,workspace,1"
        "bind=$mod,2,workspace,2"
        "bind=$mod,3,workspace,3"
        "bind=$mod,4,workspace,4"
        "bind=$mod,5,workspace,5"
        "bind=$mod,6,workspace,6"
        "bind=$mod,7,workspace,7"
        "bind=$mod,8,workspace,8"
        "bind=$mod,9,workspace,9"
        "bind=$mod,0,workspace,10"
        "bind=CTRL,1,movetoworkspace,1"
        "bind=CTRL,2,movetoworkspace,2"
        "bind=CTRL,3,movetoworkspace,3"
        "bind=CTRL,4,movetoworkspace,4"
        "bind=CTRL,5,movetoworkspace,5"
        "bind=CTRL,6,movetoworkspace,6"
        "bind=CTRL,7,movetoworkspace,7"
        "bind=CTRL,8,movetoworkspace,8"
        "bind=CTRL,9,movetoworkspace,9"
        "bind=CTRL,0,movetoworkspace,10"
      ];

      input = {
        kb_options = "caps:swapescape";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = 1;
          scroll_factor = 0.18;
        };
      };
      xwayland = {
        force_zero_scaling = true;
      };

      master = {
        new_is_master = true;
        new_on_top = true;
        no_gaps_when_only = false;
        orientation = "right";
        special_scale_factor = 0.8;
      };

      group = {
        "col.border_active" = "rgb(0F4532)";
        "col.border_inactive" = "rgb(6666cc)";
        groupbar = {
          "col.active" = "rgba(9999eeee)";
          "col.inactive" = "rgba(00000088)";
          render_titles = false;
          height = 1;
        };
      };

      decoration = {
        rounding = 2;
        active_opacity = 0.9;
        inactive_opacity = 0.5;
        blur = {
          enabled = true;
          size = 30;
          passes = 1;
        };
        drop_shadow = true;
        shadow_range = 20;
        shadow_render_power = 4;
        shadow_ignore_window = true;
        dim_inactive = true;
        dim_strength = 0.3;
      };

      animations = {
        enabled = 1;
        # bezier=idk,0.14,0.33,0.14,0.83
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "border,1,10,default"
          "fade,1,10,default"
          "workspaces,1,6,default"
        ];
        # animation=windows,1,3,idk
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
        workspace_swipe_distance = 250;
        workspace_swipe_invert = true;
        workspace_swipe_min_speed_to_force = 30;
        workspace_swipe_cancel_ratio = 0.5;
        workspace_swipe_create_new = false;
      };

      misc = {
        disable_hyprland_logo = true;
        enable_swallow = true;
        swallow_regex = "^(Alacritty|bilibili|Google-chrome|foot)$";
        focus_on_activate = true;
      };
      windowrule = [
        "float,termfloat"
        "size 960 540,termfloat"
        "rounding 20,termfloat"
        "float,polkit-kde-authentication-agent-1"
        "opacity 1.0 override 1.0 override,firefox"
        "opacity 1.0 override 1.0 override,virt-manager"
        "opacity 1.0 override 1.0 override,Google-chrome"
        "opacity 1.0 override 1.0 override,bilibili"
        "opacity 0.9 override 0.9 override,netease-cloud-music"
        "tile,netease-cloud-music"
        "group,firefox"
        "group,bilibili"
        "nodim,mpv"
        "workspace special,netease-cloud-music"
        "fullscreen,mpv"
      ];
      general = {
        sensitivity = 1.3;
        gaps_in = 5;
        gaps_out = 15;
        border_size = 2;
        "col.inactive_border" = "rgb(313244)";
        "col.active_border" = "rgb(6666cc)";
        resize_on_border = true;
        apply_sens_to_raw = 0;
        layout = "master";
      };
      exec-once = [
        "swww-daemon"
        "~/.config/hypr/scripts/swww.sh"
        "fcitx5"
        "ags"
        "wl-paste --watch cliphist store"
        # "waybar"
        # "waybar -c ~/.config/waybar/topbar/config -s ~/.config/waybar/topbar/style.css"
        "wlsunset -l 39.9 -L 116.3"
      ];
      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "XDG_SESSION_TYPE,wayland"
        "GDK_BACKEND,wayland,x11,*"
        "QT_QPA_PLATFORM,wayland;xcb"
        "SDL_VIDEODRIVER,wayland"
        "CLUTTER_BACKEND,wayland"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_QPA_PLATFORM,wayland;xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_QPA_PLATFORMTHEME,qt5ct"
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "WLR_NO_HARDWARE_CURSORS,1"
        "NVD_BACKEND,direct"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        "HYPRCURSOR_THEME,rose-pine-hyprcursor"
        "HYPRCURSOR_SIZE,38"
        "XMODIFIERS,fcitx"
        "QT_IM_MODULE=fcitx,fcitx"
      ];
    };
  };
}
