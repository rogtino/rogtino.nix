_: {
  virtualisation = {
    # TODO:enable dark theme
    # vmware.host.enable = true;
    libvirtd = {
      enable = true;
      qemu.ovmf.enable = true;
      qemu.swtpm.enable = true;
    };
    incus.enable = true;
    docker = {
      enable = true;
      daemon.settings = {
        registry-mirrors = ["https://docker.mirrors.ustc.edu.cn/"];
      };
    };
  };
}
