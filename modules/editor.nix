{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    helix
  ];

  # Set helix as default editor
  environment.variables.EDITOR = "hx";
}
