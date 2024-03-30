alias o:=update-os
alias f:=update-flake
alias n:=update-neovim

update-os *args:
  sudo nixos-rebuild switch {{args}}
update-flake:
  nix flake update
update-neovim:
  nix flake lock --update-input neovim-nightly-overlay
