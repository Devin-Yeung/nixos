{ pkgs, ... }:

{
  # Same wallpaper as the desktop, so the lock screen matches the session.
  programs.hyprlock = {
    enable = true;
    settings = {
      background = [
        {
          path = pkgs.nixos-artwork.wallpapers.binary-black.gnomeFilePath;
          blur_passes = 2;
        }
      ];

      # Without this block hyprlock shows no password field at all.
      # One dot per typed character; the field stays visible when empty.
      input-field = [
        {
          size = "250, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          dots_size = 0.25;
          fade_on_empty = false;
          font_color = "rgb(255, 255, 255)";
          inner_color = "rgba(0, 0, 0, 0)";
          outer_color = "rgba(255, 255, 255, 0.6)";
          check_color = "rgba(255, 255, 255, 0)";
          fail_color = "rgba(255, 255, 255, 0)";
          outline_thickness = 2;
          placeholder_text = "<i>Password...</i>";
          fail_text = "<i>$FAIL ($ATTEMPTS)</i>";
          shadow_passes = 0;
        }
      ];
    };
  };
}
