{ ... }:
{
  programs.zed-editor.userSettings = {
    edit_predictions = {
      provider = "zed";
    };
    # Zed is managed by Homebrew.
    auto_update = false;
    vim_mode = true;
  };
}
