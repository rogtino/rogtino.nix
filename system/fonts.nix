{pkgs, ...}: {
  # fonts
  fonts = {
    enableDefaultPackages = true;
    fontconfig = {
      enable = true;
      defaultFonts = {
        emoji = [
          "Noto Color Emoji"
        ];

        monospace = [
          # "BlexMono Nerd Font"
          # "IBM Plex Mono"
          # "JetBrainsMonoNL Nerd Font"
          # "Maple Mono NF"
          # "LXGW WenKai Mono"
          "Martian Mono"
          "IntoneMono Nerd Font"
          "Noto Color Emoji"
          "Uiua386"
        ];
        sansSerif = [
          # "Noto Sans CJK HK"
          # "Source Serif Pro"
          "LXGW WenKai"
          # "Source Han Sans SC"
          # "Noto Color Emoji"
        ];
        serif = [
          # "Noto Sans CJK HK"
          # "Source Serif Pro"
          "LXGW WenKai"
          # "Source Han Sans SC"
          # "Noto Color Emoji"
        ];
      };
    };

    packages = with pkgs; [
      (nerdfonts.override {
        fonts = [
          # "Iosevka"
          # "FiraCode"
          # "JetBrainsMono"
          "IntelOneMono"
        ];
      })
      martian-mono
      # nerdfonts
      noto-fonts-emoji
      # ibm-plex
      # intel-one-mono
      # source-serif-pro
      # source-han-sans
      fira-code
      # noto-fonts-cjk
      # maple-mono-SC-NF
      lxgw-wenkai
      uiua386
    ];
  };
}
