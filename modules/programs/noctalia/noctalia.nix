{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
    settings = {
      location = {
        name = "Auckland";
      };
      general = {
        avatarImage = "/home/michel/.face";
        animationSpeed = 2;
        dimmerOpacity = 0.9;
        enableShadows = false;
        radiusRatio = 0.5;
      };
      ui = {
        fontDefault = "Inter Nerd Font";
        fontFixed = "FiraCode Nerd Font";
        panelBackgroundOpacity = 0;
      };
      bar = {
        position = "top";
        density = "comfortable";
        backgroundOpacity = 0;
        capsuleOpacity = 0.8;
        widgets = {
          left = [
            {
              id = "ControlCenter";
              useDistroLogo = true;
              colorizeDistroLogo = true;
            }
            {
              id = "SystemMonitor";
              usePrimaryColor = true;
              cpuUsage = true;
              cpuTemperature = false;
              memoryUsage = true;
              memoryAsPercentage = true;
              networkTraffic = false;
              storageUsage = false;
            }
            {
              id = "ActiveWindow";
            }
            {
              id = "MediaMini";
              showAlbumArt = false;
              showArtistFirst = true;
              showVisualizer = false;
              maxWidth = 145;
              useFixedWidth = false;
              showProgressRing = true;
            }
          ];
          center = [
            {
              id = "Workspace";
              labelMode = "index";
            }
          ];
          right = [
            {
              id = "NotificationHistory";
              showUnreadBadge = true;
              hideBadgeWhenZero = true;
            }
            {
              id = "Tray";
              colorizeIcons = true;
              enableDrawer = true;
            }
            {
              id = "Volume";
              displayMode = "on_hover";
            }
            {
              id = "Bluetooth";
              displayMode = "on_hover";
            }
            {
              id = "WiFi";
              displayMode = "on_hover";
            }
            {
              id = "Battery";
              displayMode = "on_hover";
              warningThreshold = 30;
            }
            {
              id = "Clock";
              usePrimaryColor = true;
              formatHorizontal = "HH:mm ddd, MMM dd";
              formatVertical = "HH mm - dd MM";
            }
          ];
        };
      };
      controlCenter = {
        position = "center";
      };
      dock = {
        enabled = false;
      };
      sessionMenu = {
        powerOptions = [
          { action = "lock"; enabled = true; }
          { action = "suspend"; enabled = true; }
          { action = "hibernate"; enabled = false; }
          { action = "reboot"; enabled = true; }
          { action = "logout"; enabled = false; }
          { action = "shutdown"; enabled = true; }
        ];
      };
      brightness = {
        enableDdcSupport = true;
      };
      screenRecorder = {
        directory = "/home/michel/Videos";
      };
      wallpaper = {
        directory = "/home/michel/Pictures/Wallpapers";
      };
      colorSchemes = {
        useWallpaperColors = true;
        matugenSchemeType = "scheme-content";
      };
      templates = {
        gtk = true;
        qt = true;
        kcolorscheme = true;
        ghostty = true;
      };
    };
  };
}
