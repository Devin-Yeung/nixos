{ lib, pkgs, ... }:
{
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  # Make the power plugin's GSettings schema available in the GNOME session.
  services.desktopManager.gnome.sessionPath = [ pkgs.gnome-settings-daemon ];

  # Enforce GNOME's idle-suspend policy for all users on this machine.
  programs.dconf.profiles.user.databases = [
    {
      settings."org/gnome/settings-daemon/plugins/power" = {
        sleep-inactive-ac-timeout = lib.gvariant.mkInt32 5400;
        sleep-inactive-ac-type = "suspend";
        sleep-inactive-battery-timeout = lib.gvariant.mkInt32 5400;
        sleep-inactive-battery-type = "suspend";
      };
    }
  ];

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.firefox.enable = true;
}
