{ config, pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "lua"
      "toml"
      "gdscript"
      "kdl"
      "biome"
      "harper"
      "ayu"
      "tokyo-night"
    ];
    extraPackages = with pkgs; [
      # Language servers
      nixd
      lua-language-server
      taplo

      # Formatters/Linters
      biome

      # GDScript dependency
      netcat-openbsd
    ];
    userSettings = {
      vim_mode = true;
      languages = {
        Nix = {
          language_servers = [ "nixd" "!nil" ];
        };
      };
    };
  };
}
