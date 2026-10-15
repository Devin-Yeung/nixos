# Zed keymap
#
# For information on binding keys, see the Zed
# documentation: https://zed.dev/docs/key-bindings
#
# To see the default key bindings run `zed: open default keymap` from the command palette.
# To debug the context of a key binding, run `dev: open key context view`
{ ... }:
{
  programs.zed-editor.userKeymaps = [
    # j -> gj, k -> gk (move by display lines instead of logical lines)
    # https://github.com/zed-industries/zed/issues/6753#issuecomment-1938305740
    # https://github.com/zed-industries/zed/discussions/20863
    {
      context = "Editor && VimControl && !VimWaiting && !menu";
      bindings = {
        "j" = [
          "vim::Down"
          { display_lines = true; }
        ];
        "k" = [
          "vim::Up"
          { display_lines = true; }
        ];
      };
    }
    # Close current tab
    {
      context = "!(vim_mode == insert || vim_mode == waiting)";
      bindings = {
        "\\ x" = "pane::CloseActiveItem";
      };
    }
    # in editor but not in insert mode
    {
      context = "Editor && VimControl && !(vim_mode == insert || vim_mode == waiting)";
      bindings = {
        # Switch between tabs
        "shift-l" = "pane::ActivateNextItem";
        "shift-h" = "pane::ActivatePreviousItem";
        # add cursor to next occurrence
        "ctrl-n" = [
          "editor::SelectNext"
          { replace_newest = false; }
        ];
        # LSP quick fix
        "\\ q f" = "editor::ConfirmCodeAction";
        # Focus on agent panel
        "cmd-i" = "agent::ToggleFocus";
      };
    }
    {
      context = "Editor && vim_mode == visual";
      bindings = {
        # Stage/unstage hunk under cursor
        # todo: stage selected line not supported yet
        # see: https://github.com/zed-industries/zed/discussions/51076
        "s" = "git::ToggleStaged";
        # Add current selection to agent thread (Cmd+L)
        # Deprecated aliases: assistant::QuoteSelection, agent::QuoteSelection, <context>
        "cmd-l" = "agent::AddSelectionToThread";
        # Add a cursor to the next matching occurrence while retaining existing selections
        "ctrl-n" = [
          "editor::SelectNext"
          { replace_newest = false; }
        ];
        # Add a cursor at the first non-whitespace character of each selected line
        "ctrl-shift-n" = [
          "action::Sequence"
          [
            "editor::SplitSelectionIntoLines"
            [
              "editor::MoveToBeginningOfLine"
              {
                stop_at_soft_wraps = true;
                stop_at_indent = true;
              }
            ]
          ]
        ];
      };
    }
    # NerdTree like keybindings
    # credit: https://github.com/zed-industries/zed/issues/4753
    {
      context = "ProjectPanel && not_editing";
      bindings = {
        # remove default builtin
        "j" = "menu::SelectNext";
        "k" = "menu::SelectPrevious";
        "n" = "project_panel::NewFile";
        "N" = "project_panel::NewDirectory";
        "r" = "project_panel::Rename";
        "d" = "project_panel::Delete";
        "x" = "project_panel::Cut";
        "p" = "project_panel::Paste";
        "o" = [
          "action::Sequence"
          [
            "project_panel::Open"
            # FIXME: waiting API that can check whether current selection is folder or directory
            # "workspace::ToggleLeftDock"
          ]
        ];
      };
    }
    # Toggle File Tree
    {
      context = "Workspace && !ProjectPanel && !(vim_mode == insert || vim_mode == waiting)";
      bindings = {
        "\\ e" = "project_panel::ToggleFocus";
      };
    }
    # switching from project panel back to editor and collapse project panel
    {
      context = "ProjectPanel";
      bindings = {
        "\\ e" = [
          "action::Sequence"
          [
            "project_panel::ToggleFocus"
            "workspace::ToggleLeftDock"
          ]
        ];
      };
    }
    {
      context = "Workspace && !(vim_mode == insert || vim_mode == waiting)";
      bindings = {
        # collapse / open terminal
        "\\ t" = "workspace::ToggleBottomDock";
        # File Search
        "\\ \\" = "file_finder::Toggle";
      };
    }
    {
      context = "Workspace && !Terminal";
      bindings = {
        "cmd-1" = [
          "workspace::ActivatePane"
          0
        ];
        "cmd-2" = "terminal_panel::ToggleFocus";
        "cmd-3" = "agent::ToggleFocus";
      };
    }
    {
      context = "Terminal";
      bindings = {
        # make cmd-1 always focuses the editor, even when terminal is focused
        "cmd-1" = "terminal_panel::ToggleFocus";
        "cmd-2" = null; # do nothing, keep focus on terminal
        "cmd-3" = "agent::ToggleFocus";
        # inline chat
        "cmd-i" = "assistant::InlineAssist";
      };
    }
    {
      context = "AgentPanel > MessageEditor > Editor";
      bindings = {
        # same as cursor
        "cmd-/" = "agent::ToggleModelSelector";
      };
    }
    {
      context = "AgentPanel";
      bindings = {
        "cmd-{" = [
          "agents_sidebar::ToggleThreadSwitcher"
          { select_last = true; }
        ];
        "cmd-}" = "agents_sidebar::ToggleThreadSwitcher";
      };
    }
    {
      context = "ThreadSwitcher";
      bindings = {
        "cmd-{" = [
          "agents_sidebar::ToggleThreadSwitcher"
          { select_last = true; }
        ];
        "cmd-}" = "agents_sidebar::ToggleThreadSwitcher";
      };
    }
    # markdown preview
    {
      context = "Editor && extension == md";
      bindings = {
        "cmd-e" = "markdown::OpenPreview";
      };
    }
    # disable default "cmd-e" binding in keymap editor
    {
      context = "KeymapEditor";
      bindings = {
        "cmd-e" = null; # default is "zed::OpenKeymapFile"
      };
    }
  ];

}
