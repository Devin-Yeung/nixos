{
  programs.ghostty = {
    enable = true;

    settings = {
      # font config
      font-size = 16;
      font-family = [
        "Iosevka NFM"
        # a fallback for the chinese font
        "LXGW WenKai Mono"
      ];
      font-thicken = true;

      # theme
      theme = "Nord";

      # keybindings
      keybind = [
        # tmux compatibility
        "alt+left=unbind"
        "alt+right=unbind"
      ];
      macos-option-as-alt = "left";

      # always update manually
      auto-update = "off";

      # See: https://ghostty.org/docs/help/terminfo
      shell-integration-features = "ssh-terminfo,ssh-env";

      background-opacity = 0.5;
      background-blur = "macos-glass-regular";
      macos-titlebar-style = "transparent";
    };
  };
}
