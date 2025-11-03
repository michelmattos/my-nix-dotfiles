{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    lazyjj
  ];
}
