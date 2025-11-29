{ config, pkgs, inputs, ... }:

{
  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 180;  # 3 minutes - lock
        command = "${inputs.noctalia.packages.${pkgs.system}.default}/bin/noctalia-shell ipc call lockScreen lock";
      }
      {
        timeout = 180;  # 3 minutes - monitors off
        command = "${pkgs.niri}/bin/niri msg action power-off-monitors";
      }
    ];
    events = [
      {
        event = "before-sleep";
        command = "${inputs.noctalia.packages.${pkgs.system}.default}/bin/noctalia-shell ipc call lockScreen lock";
      }
    ];
  };
}
