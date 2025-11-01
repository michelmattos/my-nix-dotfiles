{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Michel Mattos";
        email = "7696411+michelmattos@users.noreply.github.com";
      };
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}
