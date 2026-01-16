{ config, pkgs, ... }:

{
  # Use latest kernel for better Intel Lunar Lake support
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 4;
  boot.loader.timeout = 3; # Hide boot menu (press key to show)

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
    jq
    btop
    android-tools  # adb, fastboot
    libva-utils    # vainfo for VA-API diagnostics
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Required for running dynamic binaries
  programs.nix-ld.enable = true;

  # Bluetooth support (for Noctalia Bluetooth widget)
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Intel GPU support (Lunar Lake / Xe2 architecture)
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-compute-runtime  # OpenCL + Level Zero for compute
      intel-media-driver     # VA-API (iHD) for hardware video decode/encode
      vpl-gpu-rt             # Intel Quick Sync Video runtime
    ];
  };

  # Prefer Intel iHD driver for VA-API
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };

  # Battery/power features (for Noctalia)
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  # Audio (PipeWire)
  security.rtkit.enable = true;  # Real-time scheduling for better audio performance
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # btop with CAP_PERFMON for Intel GPU monitoring
  security.wrappers.btop = {
    owner = "root";
    group = "root";
    source = "${pkgs.btop}/bin/btop";
    capabilities = "cap_perfmon+ep";
  };
}
