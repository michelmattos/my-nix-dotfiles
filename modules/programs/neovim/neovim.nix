{ config, pkgs, inputs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    # Recommended packages for AstroNvim functionality
    extraPackages = with pkgs; [
      # Core tools
      ripgrep          # Telescope grep
      fd               # Telescope file finding

      # Build tools
      gcc              # Treesitter compilation
      gnumake          # Build tool

      # Language support
      tree-sitter      # Syntax highlighting
    ];
  };

  # Link individual files and directories from AstroNvim template
  # This keeps ~/.config/nvim as a writable directory for lazy-lock.json
  xdg.configFile = {
    "nvim/init.lua".source = "${inputs.astronvim-template}/init.lua";
    "nvim/lua".source = "${inputs.astronvim-template}/lua";
    "nvim/.luarc.json".source = "${inputs.astronvim-template}/.luarc.json";
    "nvim/.neoconf.json".source = "${inputs.astronvim-template}/.neoconf.json";
    "nvim/.stylua.toml".source = "${inputs.astronvim-template}/.stylua.toml";
    "nvim/selene.toml".source = "${inputs.astronvim-template}/selene.toml";
  };
}
