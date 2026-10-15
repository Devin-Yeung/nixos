{ ... }:
{
  programs.zed-editor.userSettings.agent = {
    dock = "right";
    default_model = {
      provider = "zenmux";
      model = "anthropic/claude-haiku-5.5";
    };
    tool_permissions = {
      default = "allow";
      tools = {
        terminal = {
          always_confirm = [
            { pattern = "sudo\\s"; }
            { pattern = "git\\s+push"; }
          ];
        };
        edit_file = {
          always_deny = [
            { pattern = "\\.env"; }
            { pattern = "secrets?/"; }
            { pattern = "\\.(pem|key)$"; }
          ];
        };
        delete_path = {
          always_deny = [
            { pattern = "\\.git/?$"; }
            { pattern = "\\.env(\\..*)?$"; }
          ];
        };
      };
    };
  };
}
