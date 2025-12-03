{ config, pkgs, ... }:

{
  # Start ssh-agent automatically
  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";  # Auto-add keys when first used
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/github";
        identitiesOnly = true;
      };
    };
  };

  home.file.".ssh/github.pub".text = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDjTUJGIHAA/Rc0KUlyMxxpQSAG4alePGU9zbt8ODuCX 7696411+michelmattos@users.noreply.github.com\n";
}
