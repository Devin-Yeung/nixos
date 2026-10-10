{ pkgs, ... }:

let
  # Super+/ overlay: rofi's dedicated error-message layout. Keep its wider
  # monospaced, tab-aligned content local to this invocation so the launcher
  # retains its proportional search font.
  cheatsheet = pkgs.writeShellApplication {
    name = "rofi-cheatsheet";
    runtimeInputs = [ pkgs.rofi ];
    text = ''
      exec rofi \
        -markup \
        -theme-str 'window { width: 780px; height: 600px; } error-message { padding: 14px 18px; background-color: #ffffff08; border: 1px; border-color: #90b4ff40; border-radius: 12px; } textbox { font: "Iosevka NFM 12"; tab-stops: [ 27ch ]; }' \
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

  # Shown by Super+/. Pango markup provides the title and category hierarchy;
  # tab stops in the rofi invocation align each shortcut with its description.
  xdg.configFile."hypr/cheatsheet.txt".text = ''
    <span font="Iosevka NFM Bold 17" foreground="#ffffff">Hyprland shortcuts</span>
    <span font="Iosevka NFM 10" foreground="#8a93a3">Press Esc or Super + / to close</span>

    <span foreground="#9db8e8"><b>Applications</b></span>
    Super + Return	Open terminal
    Super + Space	Open app launcher
    Super + d	Open app launcher
    <span foreground="#9db8e8"><b>Windows</b></span>
    Super + q	Close window
    Super + f	Toggle fullscreen
    Super + Shift + v	Toggle floating
    Super + c / v	Copy / paste (Ghostty-safe)
    <span foreground="#9db8e8"><b>Focus &amp; layout</b></span>
    Super + H/J/K/L	Focus ← / ↓ / ↑ / →
    Super + Shift + H/J/K/L	Move ← / ↓ / ↑ / →
    <span foreground="#9db8e8"><b>Workspaces</b></span>
    Super + 1 … 0	Switch workspace
    Super + Shift + 1 … 0	Move to workspace
    <span foreground="#9db8e8"><b>Pointer &amp; tools</b></span>
    Super + drag (LMB)	Move floating window
    Super + drag (RMB)	Resize floating window
    Super + Shift + s	Screenshot → clipboard
    Super + Shift + c	Clipboard history
    <span foreground="#f0b480"><b>Session</b></span>
    Super + Shift + e	Exit Hyprland
  '';
}
