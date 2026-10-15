{ ... }:
{
  programs.zed-editor.userSettings = {
    ui_font_size = 20;
    ui_font_family = "Iosevka Nerd Font Mono";
    ui_font_fallbacks = [ "LXGW WenKai Mono" ];
    agent_ui_font_size = 20;
    agent_buffer_font_size = 18;
    buffer_font_size = 22;
    buffer_font_family = "Iosevka Nerd Font Mono";
    buffer_font_fallbacks = [ "LXGW WenKai Mono" ];
    theme = {
      mode = "system";
      light = "One Dark";
      dark = "Gruvbox Dark Hard";
    };
  };
}
