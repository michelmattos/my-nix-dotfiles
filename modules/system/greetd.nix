{ config, pkgs, ... }:

{
  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "niri-session";
        user = "michel";
      };
      default_session = {
        command = "niri-session";
        user = "michel";
      };
    };
  };
}
