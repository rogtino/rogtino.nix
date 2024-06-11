{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod"];
  boot.supportedFilesystems = ["ntfs"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = with config.boot.kernelPackages; [rtl8821ce];
  boot.blacklistedKernelModules = ["rtw88_8821ce"];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/c27c0ed8-f2ac-4923-b59d-1f611e7b788e";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/C5BC-E7DA";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };
  fileSystems."/home/gus/son" = {
    device = "/dev/disk/by-uuid/aa65a7cd-aa4a-49cb-b9b2-c1a09cd647af";
    fsType = "ext4";
  };
  fileSystems."/home/gus/blk" = {
    device = "/dev/disk/by-uuid/5248FFEE48FFCEAB";
    fsType = "ntfs-3g";
    options = ["rw" "uid=1000"];
  };

  swapDevices = [];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp4s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
