{ config, pkgs, ... }:

{
  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    brightnessctl        # Used by Noctalia for brightness control
    wl-clipboard         # Provides wl-copy and wl-paste for Wayland clipboard
    xwayland-satellite   # X11 app support - niri auto-spawns on-demand
  ];
}
