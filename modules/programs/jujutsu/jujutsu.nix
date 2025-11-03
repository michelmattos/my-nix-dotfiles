{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    jujutsu
  ];

  xdg.configFile."jj".source = ./dotfiles;
}
