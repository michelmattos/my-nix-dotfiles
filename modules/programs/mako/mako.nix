{ config, pkgs, ... }:

let
  # Volume notification script
  volume-notify = pkgs.writeShellScriptBin "volume-notify" ''
    # Get volume information
    volume_info=$(${pkgs.wireplumber}/bin/wpctl get-volume @DEFAULT_AUDIO_SINK@)

    # Check if muted
    if echo "$volume_info" | grep -q "MUTED"; then
        ${pkgs.libnotify}/bin/notify-send -t 1000 -a 'volume-notify' -h int:value:0 "Volume: Muted"
    else
        # Extract volume value and convert to percentage
        volume=$(echo "$volume_info" | ${pkgs.gawk}/bin/awk '{print $2}')
        volume=$(echo "( $volume * 100 ) / 1" | ${pkgs.bc}/bin/bc)

        ${pkgs.libnotify}/bin/notify-send -t 1000 -a 'volume-notify' -h int:value:$volume "Volume: ''${volume}%"
    fi
  '';

  # Brightness notification script
  brightness-notify = pkgs.writeShellScriptBin "brightness-notify" ''
    # Get current and max brightness values
    current=$(${pkgs.brightnessctl}/bin/brightnessctl get)
    max=$(${pkgs.brightnessctl}/bin/brightnessctl max)

    # Calculate percentage with proper rounding
    brightness=$(( (current * 100 + max / 2) / max ))

    ${pkgs.libnotify}/bin/notify-send -t 1000 -a 'brightness-notify' -h int:value:$brightness "Brightness: ''${brightness}%"
  '';
in
{
  # Install notification scripts
  home.packages = [
    volume-notify
    brightness-notify
  ];

  # Enable mako notification daemon
  services.mako.enable = true;

  # Link mako configuration from dotfiles
  xdg.configFile."mako".source = ./dotfiles;
}
