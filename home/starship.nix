{
  lib,
  config,
  ...
}:
let
  success_symbol = "λ.";
  error_symbol = "⊥.";
  vim_symbol = "";
in
{
  # See: https://github.com/starship/starship/issues/5522
  # and https://github.com/starship/starship/issues/3418#issuecomment-1711630970
  programs.starship.enableZshIntegration = false;
  programs.zsh.initContent = /* zsh */ ''
    if [[ $TERM != "dumb" ]]; then
      type starship_zle-keymap-select >/dev/null || eval "$(${lib.getExe config.programs.starship.package} init zsh)"
    fi
  '';

  programs.starship = {
    enable = true;
    settings = {
      character = {
        success_symbol = "[${success_symbol}](bold 240)"; # 8-bit ANSI Color Code: grey
        error_symbol = "[${error_symbol}](bold red)";
        vimcmd_symbol = "[${vim_symbol}](bold green)";
        vimcmd_replace_one_symbol = "[${vim_symbol}](bold purple)";
        vimcmd_replace_symbol = "[${vim_symbol}](bold purple)";
        vimcmd_visual_symbol = "[${vim_symbol}](bold yellow)";
      };
      container = {
        disabled = true;
      };

      nix_shell = {
        symbol = "❄️ ";
        format = "via [$symbol$state]($style) ";
      };

      hostname = {
        ssh_symbol = "📡 ";
      };
    };
  };
}
