{ config, pkgs, ... }:

{
  programs.mise = {
    enable = true;

    enableFishIntegration = true;
  };

  xdg.configFile."mise".source = ./dotfiles;
}
