{
  inputs,
  pkgs,
  ...
}:
{
  programs.herdr = {

    enable = true;
    package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.herdr;

    settings = {
      # see: https://github.com/dmmulroy/.dotfiles/blob/main/home/.config/herdr/config.toml

      onboarding = false;

      ui = {
        agent_panel_sort = "priority";
      };

      keys = {
        prefix = "ctrl+b";
        detach = "prefix+d";
        copy_mode = "prefix+[";

        # In Herdr's navigate mode (prefix + w), defaults are:
        # - Sidebar workspaces: up/down arrow keys
        # - Main panes: h/j/k/l (with arrow keys as hardcoded reserved aliases)
        # Remap j/k to navigate sidebar workspaces; pane navigation falls back
        # to the built-in directional arrow keys (do not explicitly set navigate_pane_*
        # to arrows as they are reserved aliases in Herdr).
        navigate_workspace_down = "j";
        navigate_workspace_up = "k";

        # agent navi (vertical: up / down)
        previous_agent = "alt+k";
        next_agent = "alt+j";
        open_notification_target = "prefix+o";

        # tab navi
        previous_tab = "alt+h";
        next_tab = "alt+l";

        # split pane
        split_vertical = "prefix+\"";
        split_horizontal = "prefix+%";
        close_pane = "prefix+x";
        zoom = "prefix+z";

        # pane navi
        cycle_pane_next = "ctrl+p";
        cycle_pane_previous = "ctrl+shift+p";

        command = [
          {
            key = "prefix+alt+n";
            type = "pane";
            command = "nvim";
            description = "open nvim";
          }
          {
            key = "prefix+alt+g";
            type = "pane";
            command = "lazygit";
            description = "run lazygit";
          }
        ];
      };
    };

  };
}
