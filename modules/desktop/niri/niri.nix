{ config, pkgs, ... }:

{
  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    brightnessctl  # Used by Noctalia for brightness control
    wl-clipboard   # Provides wl-copy and wl-paste for Wayland clipboard
  ];
}
