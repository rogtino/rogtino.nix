{
  lib,
  config,
  inputs,
  ...
}: {
  environment.etc."nix/inputs/nixpkgs".source = "${inputs.nixpkgs}";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    # "openssl-1.1.1w"
    # "electron-11.5.0"
  ];
  nix = {
    extraOptions = ''
      !include ${config.sops.secrets."gh".path}
    '';
    gc = {
      # automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };
    nixPath = lib.mkForce ["/etc/nix/inputs"];
    settings = {
      # Optimise storage
      # you can alse optimise the store manually via:
      #    nix-store --optimise
      # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
      auto-optimise-store = true;
      warn-dirty = false;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      # Opinionated: disable global registry
      flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
      substituters = lib.mkBefore [
        "https://mirror.sjtu.edu.cn/nix-channels/store"
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        # "https://cache.nixos.org"
      ];
      trusted-users = ["gus"];
    };
    channel.enable = false; # remove nix-channel related tools & configs, we use flakes instead.
    #BUG: this nixpkgs is different from final nixpkgs
    registry.nixpkgs.flake = inputs.nixpkgs;
  };
}
