{ pkgsNightly, lib, ... }:
let
  jj-starship = lib.getExe pkgsNightly.jj-starship;
in
{
  programs.starship.settings = {
    # support jj-vcs
    custom.jj = {
      when = "${jj-starship} detect";
      shell = [
        "${jj-starship}"
        "--no-git-id"
      ];
      format = "$output ";
    };

    # git status is managed by jj-starship
    git_branch = {
      disabled = true;
    };
    git_status = {
      disabled = true;
    };
  };
}
