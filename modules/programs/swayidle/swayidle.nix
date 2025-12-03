{ config, pkgs, inputs, ... }:

{
  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 180;  # 3 minutes - lock
        command = "${inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/noctalia-shell ipc call lockScreen lock";
      }
      {
        timeout = 180;  # 3 minutes - monitors off
        command = "${pkgs.niri}/bin/niri msg action power-off-monitors";
      }
    ];
    events = {
      before-sleep = "${inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/noctalia-shell ipc call lockScreen lock";
    };
  };
}
