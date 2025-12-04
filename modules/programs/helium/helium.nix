{ config, pkgs, lib, ... }:

let
  helium = import ./package.nix { inherit lib pkgs; };
in
{
  home.packages = [ helium ];
}
