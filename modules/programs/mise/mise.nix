{ config, pkgs, ... }:

{
  programs.mise = {
    enable = true;

    enableFishIntegration = true;
  };

  home.file.".config/mise".source = ./dotfiles;
}
