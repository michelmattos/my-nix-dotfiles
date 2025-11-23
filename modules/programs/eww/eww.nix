{ config, pkgs, ... }:

{
  programs.eww = {
    enable = true;
    configDir = ./dotfiles;
    enableFishIntegration = true;
  };

  home.packages = with pkgs; [
    jq # JSON parsing for niri IPC scripts
  ];
}
