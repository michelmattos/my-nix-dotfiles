{ config, pkgs, ... }:

{
  programs.helix.enable = true;

  xdg.configFile."helix".source = ./dotfiles;
}
