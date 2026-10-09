{
  programs.waybar = {
    enable = true;

    settings.mainBar = {
      layer = "top";
      modules-left = [
        "hyprland/workspaces"
        "hyprland/window"
      ];
      modules-right = [
        "tray"
        "pulseaudio"
        "cpu"
        "memory"
        "clock"
      ];

      "hyprland/window" = {
        max-length = 60;
        separate-outputs = true;
      };
      clock = {
        format = "{:%H:%M}";
        tooltip-format = "{:%Y-%m-%d %H:%M:%S}";
      };
    };
  };
}
