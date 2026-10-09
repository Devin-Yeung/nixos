{
  pkgs,
  lib,
  ...
}:

let
  # Supply the active pane without a trailing newline or `$` for run-shell to expand.
  copyPaneId = "printf 'My terminal is tmux pane %s; operate on it via the tmux CLI.' '#{pane_id}' | pbcopy && tmux display-message 'Pane prompt copied'";

  replacements = {
    "@copyPaneId@" = copyPaneId;
    "@tmuxJump@" = "${pkgs.tmuxPlugins.jump}/share/tmux-plugins/jump/scripts/tmux-jump.sh";
    "@zsh@" = lib.getExe pkgs.zsh;
  };
  tmuxConfig =
    ./tmux.conf
    |> builtins.readFile
    |> builtins.replaceStrings (builtins.attrNames replacements) (builtins.attrValues replacements);
in
{
  programs.tmux = {
    enable = true;
    shell = lib.getExe pkgs.zsh;
    terminal = "xterm-256color";
    plugins = [
      pkgs.tmuxPlugins.nord
      pkgs.tmuxPlugins.jump
    ];
    extraConfig = tmuxConfig;
  };
}
