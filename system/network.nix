{
  config,
  inputs,
  ...
}: {
  networking = {
    # wireless.enable = true; # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true; # Easiest to use and most distros use this by default.
    networkmanager.wifi.backend = "iwd"; # Easiest to use and most distros use this by default.
    firewall.allowedTCPPorts = [3000 8000];
    firewall.trustedInterfaces = ["lxdbr0"];
  };
  # services.daed = {
  #   enable = true;
  #
  #   openFirewall = {
  #     enable = true;
  #     port = 12345;
  #   };
  # };
  services.dae = {
    enable = true;
    # configFile = "/home/gus/example.dae";
    configFile = config.sops.secrets."config.dae".path;
    openFirewall = {
      enable = true;
      port = 12345;
    };
  };
}
