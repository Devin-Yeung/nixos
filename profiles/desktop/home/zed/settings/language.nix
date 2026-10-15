{ ... }:
{
  programs.zed-editor.userSettings = {
    lsp.nil.initialization_options.nix.flake.autoArchive = true;
    format_on_save = "on";
  };
}
