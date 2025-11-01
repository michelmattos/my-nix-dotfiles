{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    jujutsu
  ];

  home.file.".config/jj".source = ./dotfiles;
}
