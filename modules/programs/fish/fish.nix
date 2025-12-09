{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;

    functions = {
      # Custom cd with zoxide fallback (Omarchy pattern)
      cd = {
        description = "Change directory with zoxide fallback";
        body = ''
          if test (count $argv) -eq 0
            builtin cd ~
          else if test -d "$argv[1]"
            builtin cd $argv
          else
            z $argv && printf "\U000F17A9 " && pwd || echo "Directory not found"
          end
        '';
      };

      # Fuzzy directory jump with zoxide + fzf
      zd = {
        description = "Fuzzy directory jump using zoxide and fzf";
        body = ''
          set -l result (zoxide query --list | fzf --height 40% --reverse --border)
          if test -n "$result"
            cd "$result"
          end
        '';
      };
    };
  };
}
