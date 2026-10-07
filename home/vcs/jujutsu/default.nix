{
  config,
  pkgs,
  pkgsNightly,
  lib,
  ...
}:
{
  imports = [
    ./fileset-aliases.nix
    ./revset-aliases.nix
    ./starship.nix
  ];

  home.packages = [
    pkgsNightly.jjui
    pkgsNightly.jj-vine
    pkgs.jj-fzf
  ];

  programs.jujutsu = {
    enable = true;
    package = pkgsNightly.jujutsu;
    settings = {
      user = {
        name = config.programs.git.settings.user.name;
        email = config.programs.git.settings.user.email;
      };
      ui = {
        pager = "${lib.getExe pkgs.bat} -p -l help";
        diff-instructions = false;
        # work with diff using hunk.nvim
        diff-editor = [
          "nvim"
          "-c"
          "DiffEditor $left $right $output"
        ];
        default-command = "log";
      };
      # blank line between commits in `jj log`
      templates.log = "builtin_log_comfortable";

      remotes = {
        origin = {
          # auto tracking main/master branch
          auto-track-bookmarks = "main | master";
        };
      };

      revsets = {
        bookmark-advance-to = "closest_pushable(@) ~ bookmarks()";
      };
    };
  };
}
