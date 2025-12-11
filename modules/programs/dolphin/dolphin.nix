{ config, pkgs, ... }:

{
  home.packages = with pkgs.kdePackages; [
    dolphin
    qtsvg         # SVG icon support (missing icons without this)
    kio           # Required for KIO protocols
    kio-fuse      # Mount remote filesystems via FUSE
    kio-extras    # Extra protocols (SFTP, SMB, etc.)
  ];

  xdg.configFile."dolphinrc".source = ./dotfiles/dolphinrc;
}
