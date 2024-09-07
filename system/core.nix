{pkgs, ...}
: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];
  users.users.gus = {
    isNormalUser = true;
    extraGroups = ["lxd" "wheel" "sudo" "libvirtd" "video" "audio" "docker"];
    shell = pkgs.nushell;
    password = ";'";
  };

  # i18n
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = ["zh_CN.UTF-8/UTF-8" "en_US.UTF-8/UTF-8"];
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  networking = {
    hostName = "art"; # Define your hostname.
  };

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";
  hardware = {
    # List services that you want to enable:
    pulseaudio.enable = true;
    pulseaudio.support32Bit = true;
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
  };
  services = {
    # emacs.enable = true;
    # pipewire = {
    #   enable = true;
    #   alsa.enable = true;
    #   alsa.support32Bit = true;
    #   pulse.enable = true;
    #   jack.enable = true;
    #   wireplumber.enable = true;
    #   extraConfig.pipewire."92-low-latency" = {
    #     "context.properties" = {
    #       "default.clock.rate" = 44100;
    #       "default.clock.quantum" = 512;
    #       "default.clock.min-quantum" = 512;
    #       "default.clock.max-quantum" = 512;
    #     };
    #   };
    # };
    openssh.enable = true;
    blueman.enable = true;
    xserver = {
      # mpd.enable = true;
      enable = true;
      # v2raya.enable = true;
      # xserver.displayManager.gdm = {
      #   enable = true;
      # };
      # desktopManager.plasma6.enable = true;
      xkb.options = "caps:swapescape";
    };
    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;
  };

  security = {
    sudo.wheelNeedsPassword = false;
    rtkit.enable = true;
    polkit.enable = true;
  };

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

  environment = {
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      # PRISMA_QUERY_ENGINE_LIBRARY = "${pkgs.prisma-engines}/lib/libquery_engine.node";
      # PRISMA_QUERY_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/query-engine";
      # PRISMA_SCHEMA_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/schema-engine";
      PRISMA_ENGINES_CHECKSUM_IGNORE_MISSING = "1";
    };
  };

  # programs = {
  #   dconf.enable = true;
  # };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
}
