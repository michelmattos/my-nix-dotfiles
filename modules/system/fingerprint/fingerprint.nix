{ config, pkgs, lib, ... }:

{
  # Enable fprintd service
  services.fprintd.enable = true;

  # Enable fingerprint auth for sudo and login
  security.pam.services.sudo.fprintAuth = true;
  security.pam.services.login.fprintAuth = true;

  # Enable fingerprint auth for greetd if it's enabled
  security.pam.services.greetd = lib.mkIf config.services.greetd.enable {
    fprintAuth = true;
  };
}
