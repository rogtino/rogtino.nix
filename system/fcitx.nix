{
  pkgs,
  config,
  ...
}
: let
  rime-rogtino-custom = pkgs.callPackage ./rime-rogtino-custom.nix {};

  fcitx5-rime-with-addons =
    (pkgs.fcitx5-rime.override {
      librime = config.nur.repos.xddxdd.lantianCustomized.librime-with-plugins;
      rimeDataPkgs = with config.nur.repos.xddxdd;
      with pkgs; [
        rime-aurora-pinyin
        # rime-custom-pinyin-dictionary
        rime-data
        rime-dict
        rime-ice
        rime-rogtino-custom
        rime-moegirl
        rime-zhwiki
      ];
    })
    .overrideAttrs (old: {
      # Prebuild schema data
      nativeBuildInputs = (old.nativeBuildInputs or []) ++ [pkgs.parallel];
      postInstall =
        (old.postInstall or "")
        + ''
          for F in $out/share/rime-data/*.schema.yaml; do
            echo "rime_deployer --compile "$F" $out/share/rime-data $out/share/rime-data $out/share/rime-data/build" >> parallel.lst
          done
          parallel -j$(nproc) < parallel.lst || true
        '';
    });
in {
  i18n = {
    inputMethod = {
      type = "fcitx5";
      enable = true;
      #TODO:disable rime in wsl
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          fcitx5-gtk
          libsForQt5.fcitx5-qt
          fcitx5-rime-with-addons
          fcitx5-rose-pine
        ];
      };
    };
  };
}
