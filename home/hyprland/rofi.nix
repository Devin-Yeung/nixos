{ pkgs, ... }:

let
  # Super+/ overlay: rofi's message window. The key columns are aligned with
  # spaces, so only this window gets a monospace font — injected here rather
  # than in the theme, where a bare `textbox` rule would also hit the
  # launcher's search entry.
  cheatsheet = pkgs.writeShellApplication {
    name = "rofi-cheatsheet";
    runtimeInputs = [ pkgs.rofi ];
    text = ''
      exec rofi \
        -theme-str 'textbox { font: "monospace 14"; }' \
        -e "$(< "$HOME/.config/hypr/cheatsheet.txt")"
    '';
  };
in
{
  programs.rofi = {
    enable = true;
    terminal = "ghostty";
    font = "sans-serif 15";
    theme = ./rofi.rasi;
    extraConfig = {
      show-icons = true;
      icon-theme = "Adwaita";
      drun-display-format = "{name}";
      display-drun = "Applications";
    };
  };

  home.packages = [ cheatsheet ];

  # Shown by Super+/. Keep the key column aligned with spaces.
  xdg.configFile."hypr/cheatsheet.txt".text = ''
    Super + Return        Open terminal (Ghostty)
    Super + Space         App launcher (rofi, like macOS Cmd+Space)
    Super + d             Same as above
    Super + q             Close focused window
    Super + f             Toggle fullscreen
    Super + c / v         Copy / paste (terminal-safe in Ghostty)
    Super + Shift + v     Toggle floating/tiled
    Super + hjkl          Move focus (left/down/up/right)
    Super + Shift + hjkl  Move window
    Super + 1..0          Switch to workspace 1-10
    Super + Shift + 1..0  Move window to workspace
    Super + drag (LMB)    Move floating window
    Super + drag (RMB)    Resize floating window
    Super + Shift + s     Screenshot selection to clipboard
    Super + Shift + c     Clipboard history
    Super + Shift + e     Exit Hyprland
  '';
}
