{ config, pkgs, ... }:

{
  # Install Nerd Fonts for terminal and editor icons
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.hack
  ];
}
