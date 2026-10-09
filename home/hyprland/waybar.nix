{
  programs.waybar = {
    enable = true;
    style = ./waybar.css;

    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 38;
      margin = "10 12 0 12";
      spacing = 6;
      modules-center = [ "clock" ];
      modules-left = [
        "hyprland/workspaces"
        "hyprland/window"
      ];
      modules-right = [
        "tray"
        "pulseaudio"
        "cpu"
        "memory"
      ];

      "hyprland/workspaces" = {
        format = "{name}";
        on-click = "activate";
        disable-scroll = true;
      };
      tray.spacing = 10;
      pulseaudio = {
        format = "Vol {volume}%";
        format-muted = "Muted";
        on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      };
      cpu = {
        format = "CPU {usage}%";
        interval = 5;
      };
      memory = {
        format = "RAM {percentage}%";
        interval = 5;
      };
      "hyprland/window" = {
        max-length = 60;
        separate-outputs = true;
      };
      clock = {
        format = "{:%a  %H:%M}";
        format-alt = "{:%Y-%m-%d  %H:%M}";
        tooltip-format = "{:%Y-%m-%d %H:%M:%S}";
      };
    };
  };
}
