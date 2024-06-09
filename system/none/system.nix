{
  pkgs,
  config,
  inputs,
  ...
}
: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.cudaSupport = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gus = {
    isNormalUser = true;
    extraGroups = ["lxd" "wheel" "sudo" "libvirtd" "video" "audio" "docker"];
    shell = pkgs.fish;
    password = ";'";
  };
  programs.fish.enable = true;
  programs.dconf.enable = true;

  # i18n
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = ["zh_CN.UTF-8/UTF-8" "en_US.UTF-8/UTF-8"];
  };

  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  networking = {
    hostName = "art"; # Define your hostname.
    # wireless.enable = true; # Enables wireless support via wpa_supplicant.
    firewall.allowedTCPPorts = [3000 8000];
    firewall.trustedInterfaces = ["lxdbr0"];
  };

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # List services that you want to enable:
  services = {
    # mpd.enable = true;
    xserver.enable = true;
    openssh.enable = true;
  };

  security.sudo.wheelNeedsPassword = false;
  security.rtkit.enable = true;
  # security.polkit.enable = true;

  programs = {
    ssh.startAgent = true;
    npm = {
      enable = true;
      # npmrc = ''
      #   registry = https://registry.npmmirror.com/
      # '';
    };
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
  # Use the systemd-boot EFI boot loader.
  boot = {
    supportedFilesystems = ["ntfs"];
  };
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
    lxd.enable = true;
    docker = {
      enable = true;
      daemon.settings = {
        registry-mirrors = ["https://docker.mirrors.ustc.edu.cn/"];
      };
    };
  };
}
