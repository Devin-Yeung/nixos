{ ... }:
{
  programs.zed-editor.userSettings = {
    inlay_hints = {
      enabled = true;
      show_type_hints = true;
      show_parameter_hints = true;
      show_other_hints = true;
    };
    terminal = {
      option_as_meta = true;
    };
    diagnostics = {
      # Enable inline diagnostics.
      inline = {
        enabled = true;
      };
    };
    project_panel = {
      dock = "left";
    };
  };
}
