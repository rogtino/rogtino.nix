alias o:=update-os
alias f:=update-flake
alias n:=update-neovim
alias m:=edit-mini
alias c:=clear
alias b:=clear-boot

update-os *args:
  sudo nixos-rebuild switch {{args}}
update-flake:
  nix flake update
update-neovim:
  nix flake lock --update-input neovim-nightly-overlay
edit-mini:
  nix run nixpkgs#sops secrets/mimi.yaml
clear:
  sudo nix-collect-garbage -d
clear-boot:
  sudo /run/current-system/bin/switch-to-configuration boot
