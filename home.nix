{ config, pkgs, ... }:

{
  imports = [
    ./modules/programs/helix/helix.nix
    ./modules/programs/alacritty/alacritty.nix
    ./modules/programs/git/git.nix
    ./modules/programs/jujutsu/jujutsu.nix
    ./modules/programs/fish/fish.nix
    ./modules/programs/mise/mise.nix
  ];

  home.file.".config/niri".source = ./modules/desktop/niri/dotfiles;

  home.sessionVariables = {
    EDITOR = "hx";
  };

  home.stateVersion = "25.05";
}
