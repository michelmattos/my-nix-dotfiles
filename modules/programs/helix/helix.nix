{ config, pkgs, ... }:

{
  programs.helix.enable = true;

  home.file.".config/helix".source = ./dotfiles;
}
