# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/common.nix
      ../../modules/desktop.nix
      ../../modules/networking.nix
      ../../modules/editor.nix
      ../../modules/users.nix
    ];

  networking.hostName = "thinkpad";

  # Set helix as default editor
  environment.variables.EDITOR = "hx";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.05";
}
