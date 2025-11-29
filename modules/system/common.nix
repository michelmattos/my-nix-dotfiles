{ config, pkgs, ... }:

{
  # Boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 4;
  boot.loader.timeout = 0; # Hide boot menu (press key to show)
  boot.initrd.luks.devices."luks-06bfc710-ef22-436e-851a-98dd239aeb9a".device = "/dev/disk/by-uuid/06bfc710-ef22-436e-851a-98dd239aeb9a";

  # Plymouth for graphical LUKS password prompt
  boot.plymouth = {
    enable = true;
    theme = "hexagon_dots_alt";
    themePackages = [
      (pkgs.adi1090x-plymouth-themes.override {
        selected_themes = [ "hexagon_dots_alt" ];
      })
    ];
  };
  boot.initrd.systemd.enable = true;

  # Silent boot
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;
  boot.kernelParams = [
    "quiet"
    "splash"
    "loglevel=3"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
  ];

  # Garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

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

  # Bluetooth support (for Noctalia Bluetooth widget)
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Battery/power features (for Noctalia)
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
}
