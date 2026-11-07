{ inputs, ... }:
{
  imports = [ inputs.nix-index-database.homeModules.nix-index ];

  # Prebuilt nix-index database (refreshed weekly upstream), no local indexing needed.
  programs.nix-index = {
    enable = true;
    # Shell `command_not_found` hooks run `nix-locate` on every miss,
    # which is the slow path. Keep only `comma` for on-demand execution.
    enableBashIntegration = false;
    enableZshIntegration = false;
    enableFishIntegration = false;
    enableNushellIntegration = false;
  };

  programs.nix-index-database.comma.enable = true;
  programs.command-not-found.enable = false;
}
