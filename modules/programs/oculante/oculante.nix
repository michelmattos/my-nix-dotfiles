{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    oculante
  ];

  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "image/png" = "oculante.desktop";
    "image/jpeg" = "oculante.desktop";
    "image/gif" = "oculante.desktop";
    "image/webp" = "oculante.desktop";
    "image/bmp" = "oculante.desktop";
    "image/tiff" = "oculante.desktop";
    "image/svg+xml" = "oculante.desktop";
    "image/x-icon" = "oculante.desktop";
    "image/avif" = "oculante.desktop";
    "image/heic" = "oculante.desktop";
    "image/heif" = "oculante.desktop";
  };
}
