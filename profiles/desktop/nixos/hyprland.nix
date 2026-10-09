{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Sets the system keyboard layout (localectl); Hyprland defaults to "us" too.
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
