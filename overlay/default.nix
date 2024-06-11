{inputs, ...}: {
  nixpkgs.overlays = [
    # inputs.neovim-nightly-overlay.overlay
    # inputs.nur.overlay
    inputs.rust-overlay.overlays.default
  ];
}
