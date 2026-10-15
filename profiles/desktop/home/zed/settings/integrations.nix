{ ... }:
{
  programs.zed-editor.userSettings = {
    agent_servers = {
      cursor = {
        type = "custom";
        command = "cursor-agent";
        args = [ "acp" ];
        env = { };
      };
    };
    auto_install_extensions = {
      tombi = true;
      toml = true;
      oxc = true;
      nix = true;
      vitesse-theme-refined = true;
    };
  };
}
