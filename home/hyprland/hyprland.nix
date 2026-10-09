{ lib, pkgs, ... }:

let
  # GUI apps use Ctrl+C/V; Ghostty uses Ctrl+Shift+C/V. In particular,
  # never forward Ctrl+C to the terminal, where it would send SIGINT.
  clipboardShortcut = pkgs.writeShellApplication {
    name = "hypr-clipboard-shortcut";
    runtimeInputs = [
      pkgs.hyprland
      pkgs.jq
    ];
    text = ''
      window=$(hyprctl -j activewindow)
      address=$(jq -r '.address // empty' <<< "$window")
      [[ -n "$address" && "$address" != "0x0" ]] || exit 0

      modifiers=CTRL
      case "$(jq -r '.class' <<< "$window")" in
        com.mitchellh.ghostty*) modifiers="CTRL SHIFT" ;;
      esac

      # Target the captured window, even if focus changes before dispatch.
      exec hyprctl dispatch sendshortcut "$modifiers, $1, address:$address"
    '';
  };

  # $mod+<n> switches to workspace n, $mod+Shift+<n> moves the window there.
  workspaceBinds =
    lib.range 1 10
    |> map (
      i:
      let
        key = toString i;
        ws = toString (lib.mod i 10);
      in
      [
        "$mod, ${key}, workspace, ${ws}"
        "$mod SHIFT, ${key}, movetoworkspace, ${ws}"
      ]
    )
    |> lib.lists.flatten;
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    # Hyprland 0.55 switched its config language to Lua and Home Manager's
    # settings-to-Lua translation is still broken (it emits invalid Lua like
    # `hl.$mod(...)`). Stay on hyprlang, which 0.55 still accepts.
    configType = "hyprlang";
    xwayland.enable = true;

    settings = {
      "$mod" = "SUPER";

      exec-once = [
        "waybar"
        "mako"
        "wl-paste --watch cliphist store"
      ];

      bind = [
        # Apps
        "$mod, Return, exec, ghostty"
        "$mod, d, exec, rofi -show drun"
        # Spotlight muscle memory from macOS
        "$mod, space, exec, rofi -show drun"
        # Cheat sheet: Super+/ shows all keybinds
        "$mod, slash, exec, rofi -e \"$(< $HOME/.config/hypr/cheatsheet.txt)\""

        # Windows
        "$mod, q, killactive"
        "$mod, f, fullscreen"
        "$mod SHIFT, v, togglefloating"
        "$mod SHIFT, e, exit"

        # Focus (vim-style)
        "$mod, h, movefocus, l"
        "$mod, j, movefocus, d"
        "$mod, k, movefocus, u"
        "$mod, l, movefocus, r"

        # Move windows (vim-style)
        "$mod SHIFT, h, movewindow, l"
        "$mod SHIFT, j, movewindow, d"
        "$mod SHIFT, k, movewindow, u"
        "$mod SHIFT, l, movewindow, r"

        # macOS-style copy/paste, with terminal-safe shortcuts in Ghostty.
        "$mod, c, exec, ${lib.getExe clipboardShortcut} C"
        "$mod, v, exec, ${lib.getExe clipboardShortcut} V"

        # Screenshots: selection to clipboard; pick from history
        "$mod SHIFT, s, exec, grim -g \"$(slurp)\" - | wl-copy"
        "$mod SHIFT, c, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
      ]
      ++ workspaceBinds;

      # $mod + left/right drag to move/resize floating windows
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };

  # Shown by Super+/. Keep the key column aligned with spaces (rendered in
  # a monospace rofi message window).
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
