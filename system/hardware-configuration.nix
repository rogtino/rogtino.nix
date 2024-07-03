{
  config,
  lib,
  # pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod"];
  boot.supportedFilesystems = ["ntfs" "bcachefs"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModprobeConfig = ''
    options rtw88_pci      disable_aspm=Y
  '';
  # boot.extraModulePackages = [config.boot.kernelPackages.rtw88];
  # boot.blacklistedKernelModules = ["rtw88_8821ce"];
  boot.kernel.sysctl = {
    "net.ipv4.tcp_congestion_control" = "bbr";
  };

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
    device = "/dev/disk/by-uuid/d0920f9d-3ac5-4eaa-b27f-f30f88f0220e";
    fsType = "bcachefs";
    options = ["rw"];
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
