{
  pkgs,
  config,
  inputs,
  ...
}
: let
  hyprland = inputs.hyprland.packages.${pkgs.system}.hyprland;
  hyprland-nvidia-session = pkgs.writeTextFile {
    name = "hyprland-nvidia.desktop";
    destination = "/share/wayland-sessions/hyprland-nvidia.desktop";
    text = ''
      [Desktop Entry]
      Comment=An intelligent dynamic tiling Wayland compositor (with more nvidia)
      Exec=nvidia-offload Hyprland
      Name=Hyprland-nvidia
      Type=Application
      Version=1.4
    '';
    checkPhase = ''${pkgs.buildPackages.desktop-file-utils}/bin/desktop-file-validate "$target"'';
    derivationArgs = {passthru.providedSessions = ["hyprland-nvidia"];};
  };
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];
  # nixpkgs.config.cudaSupport = true;
  sops.defaultSopsFile = ../secrets/mimi.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/gus/.config/sops/age/keys.txt";
  sops.secrets."config.dae" = {
    owner = config.users.users.gus.name;
  };
  sops.secrets."gh" = {};
  users.users.gus = {
    isNormalUser = true;
    extraGroups = ["lxd" "wheel" "sudo" "libvirtd" "video" "audio" "docker"];
    shell = pkgs.nushell;
    password = ";'";
  };

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
          # "Intel One Mono"
          # "JetBrainsMonoNL Nerd Font"
          # "Maple Mono NF"
          # "LXGW WenKai Mono"
          "Martian Mono"
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
  # i18n
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = ["zh_CN.UTF-8/UTF-8" "en_US.UTF-8/UTF-8"];
    inputMethod.enabled = "fcitx5";
    inputMethod.fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-chinese-addons
      ];
    };
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  networking = {
    hostName = "art"; # Define your hostname.
    # wireless.enable = true; # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true; # Easiest to use and most distros use this by default.
    networkmanager.wifi.backend = "iwd"; # Easiest to use and most distros use this by default.
    firewall.allowedTCPPorts = [3000 8000];
    firewall.trustedInterfaces = ["lxdbr0"];
  };

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # List services that you want to enable:
  services = {
    # emacs.enable = true;
    dae = {
      enable = true;
      # configFile = "/home/gus/example.dae";
      configFile = config.sops.secrets."config.dae".path;
      openFirewall = {
        enable = true;
        port = 12345;
      };
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;
    };
    # mpd.enable = true;
    # blueman.enable = true;
    xserver.enable = true;
    openssh.enable = true;
    # v2raya.enable = true;
    displayManager.sessionPackages = [hyprland-nvidia-session];
    xserver.displayManager.gdm = {
      enable = true;
    };
    # desktopManager.plasma6.enable = true;
    xserver.xkb.options = "caps:swapescape";
    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;
  };

  # Enable sound.
  sound.enable = true;

  security.sudo.wheelNeedsPassword = false;
  security.rtkit.enable = true;
  # security.polkit.enable = true;

  programs = {
    ssh.startAgent = true;
    light.enable = true;
    npm = {
      enable = true;
      # npmrc = ''
      #   registry = https://registry.npmmirror.com/
      # '';
    };
    gnupg.agent = {
      enable = true;
      # enableSSHSupport = true;
    };
  };
  # programs.mtr.enable = true;
  programs.hyprland = {
    enable = true;
    package = hyprland;
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?
  # Use the systemd-boot EFI boot loader.
  boot = {
    # supportedFilesystems = ["ntfs"];
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
    };
    kernelPackages = pkgs.linuxPackages_6_8;
    # kernelPackages = pkgs.linuxPackages_latest;
  };
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=5s
  '';

  environment = {
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      PRISMA_QUERY_ENGINE_LIBRARY = "${pkgs.prisma-engines}/lib/libquery_engine.node";
      PRISMA_QUERY_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/query-engine";
      PRISMA_SCHEMA_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/schema-engine";
      PRISMA_ENGINES_CHECKSUM_IGNORE_MISSING = "1";
    };
  };
  virtualisation = {
    # TODO:enable dark theme
    # vmware.host.enable = true;
    libvirtd = {
      enable = true;
      qemu.ovmf.enable = true;
      qemu.swtpm.enable = true;
    };
    lxd.enable = true;
    docker = {
      enable = true;
      daemon.settings = {
        registry-mirrors = ["https://docker.mirrors.ustc.edu.cn/"];
      };
    };
  };

  # programs = {
  #   dconf.enable = true;
  # };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
}
