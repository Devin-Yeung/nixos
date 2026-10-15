{ pkgsNightly, ... }:
{
  imports = [
    ./models
    ./settings
    ./keybindings
  ];
  programs.zed-editor = {
    enable = true;

    # use homebrew to manage zed
    package = pkgsNightly.zed-editor;

    mutableUserSettings = false;
    mutableUserKeymaps = false;
  };
}
