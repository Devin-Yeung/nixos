{
  programs.rofi = {
    enable = true;
    terminal = "ghostty";
    font = "sans-serif 13";
    theme = ./launcher.rasi;
    extraConfig = {
      show-icons = true;
      icon-theme = "Adwaita";
      drun-display-format = "{name}";
      display-drun = "Applications";
    };
  };
}
