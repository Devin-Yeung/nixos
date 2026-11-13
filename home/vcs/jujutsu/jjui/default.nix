{ pkgsNightly, ... }:
{
  programs.jjui = {
    enable = true;
    package = pkgsNightly.jjui;

    settings = {
      actions = [
        {
          name = "custom.copy_change_id";
          desc = "Copy change ID";
          lua = builtins.readFile ./copy-change-id.lua;
        }
        {
          name = "custom.copy_checked_change_ids";
          desc = "Copy selected change IDs";
          lua = builtins.readFile ./copy-checked-change-ids.lua;
        }
      ];

      bindings = [
        {
          key = "y";
          action = "custom.copy_change_id";
          scope = "revisions";
          desc = "copy change ID";
        }
        {
          key = "alt+y";
          action = "custom.copy_checked_change_ids";
          scope = "revisions";
          desc = "copy selected change IDs";
        }
        {
          key = "shift+y";
          action = "revisions.open_duplicate";
          scope = "revisions";
          desc = "duplicate";
        }
        {
          key = "i";
          action = "revisions.open_inline_describe";
          scope = "revisions";
        }
        {
          key = "enter";
          action = "revisions.inline_describe.accept";
          scope = "revisions.inline_describe";
        }
        {
          key = "shift+enter";
          action = "revisions.inline_describe.new_line";
          scope = "revisions.inline_describe";
        }
        {
          key = "ctrl+g";
          action = "revisions.describe";
          scope = "revisions";
        }
        # s squashes and shift+s splits, in the log and in details.
        {
          key = "s";
          action = "revisions.open_squash";
          scope = "revisions";
          desc = "squash";
        }
        {
          key = "shift+s";
          action = "revisions.split";
          scope = "revisions";
          desc = "split";
        }
        {
          key = "s";
          action = "revisions.details.squash";
          scope = "revisions.details";
          desc = "squash";
        }
        {
          key = "shift+s";
          action = "revisions.details.split";
          scope = "revisions.details";
          desc = "split";
        }
      ];
    };
  };
}
