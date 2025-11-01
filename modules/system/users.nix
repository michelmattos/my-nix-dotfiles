{ config, pkgs, ... }:

{
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "workman";
  };

  # Set fish as default shell for all users
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.michel = {
    isNormalUser = true;
    description = "Michel Mattos";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}
