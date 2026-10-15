{
  # Screen lock (Super+E). This only locks a running session; logging out and
  # logging in again is handled by the display manager (display-manager.nix).
  # Enabling it here also sets up the PAM service hyprlock uses for the password
  # check. The look of the lock screen lives in home/hyprland/lock.nix.
  programs.hyprlock.enable = true;
}
