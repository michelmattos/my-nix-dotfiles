{ config, pkgs, ... }:

{
  # Boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-06bfc710-ef22-436e-851a-98dd239aeb9a".device = "/dev/disk/by-uuid/06bfc710-ef22-436e-851a-98dd239aeb9a";

  # Timezone and locale
  time.timeZone = "Pacific/Auckland";
  i18n.defaultLocale = "en_NZ.UTF-8";
  
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_NZ.UTF-8";
    LC_IDENTIFICATION = "en_NZ.UTF-8";
    LC_MEASUREMENT = "en_NZ.UTF-8";
    LC_MONETARY = "en_NZ.UTF-8";
    LC_NAME = "en_NZ.UTF-8";
    LC_NUMERIC = "en_NZ.UTF-8";
    LC_PAPER = "en_NZ.UTF-8";
    LC_TELEPHONE = "en_NZ.UTF-8";
    LC_TIME = "en_NZ.UTF-8";
  };

  # Common packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Required for running dynamic binaries
  programs.nix-ld.enable = true;
}
