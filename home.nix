{ config, pkgs, ... }:

{
  imports = [
    ./modules/programs/helix/helix.nix
    ./modules/programs/alacritty/alacritty.nix
    ./modules/programs/git/git.nix
    ./modules/programs/jujutsu/jujutsu.nix
    ./modules/programs/fish/fish.nix
    ./modules/programs/mise/mise.nix
    ./modules/programs/zen-browser/zen-browser.nix
  ];

  home.file.".config/niri".source = ./modules/desktop/niri/dotfiles;

  home.sessionVariables = {
    EDITOR = "hx";
  };

  # GTK theme configuration for dark mode
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  # Set dark mode preference for modern applications
  # This is the primary mechanism for dark mode in niri
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  home.stateVersion = "25.05";
}
