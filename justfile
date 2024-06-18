alias o:=update-os
alias w:=update-wsl
alias f:=update-flake
alias n:=update-neovim
alias m:=edit-mini
alias c:=clear
alias b:=clear-boot

update-os *args:
  sudo nixos-rebuild switch --flake .#art {{args}}
update-wsl *args:
  sudo nixos-rebuild switch --flake .#none {{args}}
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
check:
  nix flake check
