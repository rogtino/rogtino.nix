{
  lib,
  config,
  inputs,
  ...
}: {
  # environment.etc."nix/inputs/nixpkgs".source = "${nixpkgs}";

  nix.nixPath = lib.mkForce ["/etc/nix/inputs"];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];
  nix = {
    extraOptions = ''
      !include ${config.sops.secrets."gh".path}
    '';
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };
    settings = {
      # Optimise storage
      # you can alse optimise the store manually via:
      #    nix-store --optimise
      # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://mirror.sjtu.edu.cn/nix-channels/store"
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://mirrors.ustc.edu.cn/nix-channels/store"
      ];
      trusted-users = ["gus"];
    };
    channel.enable = false; # remove nix-channel related tools & configs, we use flakes instead.
    registry.nixpkgs.flake = inputs.nixpkgs;
  };
}
