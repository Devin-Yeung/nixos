{ ... }:
{
  programs.zed-editor.userSettings.git = {
    worktree_directory = ".git/zed-worktrees";
    inline_blame = {
      enabled = true;
      show_commit_summary = true;
    };
  };
}
