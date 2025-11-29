{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/system/common.nix
      ../../modules/system/networking.nix
      ../../modules/system/users.nix
      ../../modules/system/greetd.nix
      ../../modules/desktop/niri/niri.nix
    ];

  networking.hostName = "thinkpad";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.shellAliases = {
    nixrebuild = "sudo nixos-rebuild switch --flake ~/.config/nixos#thinkpad";
  };

  system.stateVersion = "25.05";
}
