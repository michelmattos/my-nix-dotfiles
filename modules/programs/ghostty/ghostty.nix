{ config, pkgs, ... }:

{
  programs.ghostty.enable = true;

  xdg.configFile."ghostty".source = ./dotfiles;
}
