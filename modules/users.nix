{ config, pkgs, ... }:

{
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "workman";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.michel = {
    isNormalUser = true;
    description = "Michel Mattos";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
}
