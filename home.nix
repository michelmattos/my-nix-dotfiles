{ config, pkgs, lib, inputs, hostname, ... }:

{
  imports = [
    ./modules/desktop/fonts/fonts.nix
    ./modules/programs/helix/helix.nix
    ./modules/programs/ghostty/ghostty.nix
    ./modules/programs/git/git.nix
    ./modules/programs/jujutsu/jujutsu.nix
    ./modules/programs/lazygit/lazygit.nix
    ./modules/programs/lazyjj/lazyjj.nix
    ./modules/programs/fish/fish.nix
    ./modules/programs/zoxide/zoxide.nix
    ./modules/programs/fzf/fzf.nix
    ./modules/programs/eza/eza.nix
    ./modules/programs/direnv/direnv.nix
    ./modules/programs/mise/mise.nix
    ./modules/programs/neovim/neovim.nix
    ./modules/programs/zen-browser/zen-browser.nix
    ./modules/programs/zed/zed.nix
    ./modules/programs/noctalia/noctalia.nix  # Replaces eww, mako, fuzzel, swaylock
    ./modules/programs/tte/tte.nix
    ./modules/programs/swayidle/swayidle.nix
    ./modules/programs/ssh/ssh.nix
    ./modules/programs/chromium/chromium.nix
    ./modules/programs/dolphin/dolphin.nix
    ./modules/programs/oculante/oculante.nix
    ./modules/programs/gnome-sound-recorder/gnome-sound-recorder.nix
  ];

  xdg.configFile."niri/config.kdl".text = let
    baseConfig = builtins.readFile ./modules/desktop/niri/dotfiles/config.kdl;
    hostConfig = lib.optionalString (builtins.pathExists ./modules/desktop/niri/dotfiles/${hostname}.kdl)
      (builtins.readFile ./modules/desktop/niri/dotfiles/${hostname}.kdl);
  in
    baseConfig + "\n" + hostConfig;

  home.shellAliases = {
    n = "nvim";
    ll = "eza -lh --group-directories-first --icons=auto";
    la = "eza -lah --group-directories-first --icons=auto";
    lt = "eza -lh --tree --level=2 --icons=auto";
  };

  home.sessionVariables = {
    EDITOR = "hx";
  };

  # GTK theme configuration
  # GTK4/libadwaita apps use dconf color-scheme (below), not theme packages
  # This is only needed for GTK2/GTK3 apps
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
  };

  # Dark mode for GTK4/libadwaita and modern apps
  # This is the correct mechanism - gtk-application-prefer-dark-theme is deprecated
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  # Qt theming to match GTK dark theme
  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

  home.stateVersion = "25.05";
}
