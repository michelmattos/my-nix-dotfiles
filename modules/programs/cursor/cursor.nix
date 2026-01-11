{ config, pkgs, ... }:

{
  # Cursor - AI-powered code editor (fork of VS Code)
  # https://cursor.com
  # Available in nixpkgs-unstable as code-cursor
  home.packages = with pkgs; [
    code-cursor
  ];
}
