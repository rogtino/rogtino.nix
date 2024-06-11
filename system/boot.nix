{pkgs, ...}: {
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
}
