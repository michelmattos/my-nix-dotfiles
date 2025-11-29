{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    terminaltexteffects
  ];
}
