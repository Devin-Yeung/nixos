{
  pkgs,
  lib,
  ...
}:
{
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      user = {
        name = lib.mkDefault "Devin-Yeung";
        email = lib.mkDefault "53309384+Devin-Yeung@users.noreply.github.com";
      };
      alias = {
        st = "status";
        co = "checkout";
        br = "branch";
        ci = "commit";
        ds = "diff --staged";
        # git log with diff patch
        plog = "log -p --ext-diff";
        # raw blame
        raw-blame = "!git --no-pager blame";
        # raw diff
        raw-diff = "!git --no-pager diff --no-ext-diff";
      };
      # automatically remove stale remote-tracking branches during fetch/pull
      fetch = {
        prune = true;
      };
      push = {
        autoSetupRemote = true;
      };
      # https://git-scm.com/book/en/v2/Git-Tools-Rerere
      rerere = {
        enabled = true;
      };
      # let git handle the whitespace in a proper way
      apply = {
        ignoreWhitespace = "change";
        whitespace = "warn";
      };
      # better git blame
      pager = {
        blame = "${lib.getExe pkgs.delta} --blame-palette 'red green' --blame-code-style=syntax";
      };
      # rewrite GitHub URLs to SSH
      url = {
        "git@github.com:Devin-Yeung" = {
          insteadOf = [
            "git@ssh.github.com:Devin-Yeung"
            "https://github.com/Devin-Yeung"
          ];
        };
      };
    };
  };

  programs.git.ignores = [
    # macOS
    ".DS_Store"
    ".AppleDouble"
    ".LSOverride"

    # Nix
    "result"
    "result-*"

    # direnv / devenv
    ".direnv/"
    ".devenv/"

    # Editors
    ".vscode/"
    ".idea/"
    "*.swp"
    "*.swo"
    "*~"

    # env
    ".env"
    ".env.*"
    "!.env.example"
    "!.env.sample"
    "!.env.template"
    "!.env.dist"
  ];
}
