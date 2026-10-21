{ inputs, ... }:
{
  imports = [ inputs.nix-index-database.homeModules.nix-index ];

  # Prebuilt nix-index database (refreshed weekly upstream), no local indexing needed.
  programs.nix-index.enable = true;
  programs.nix-index-database.comma.enable = true;
  programs.command-not-found.enable = false;
}
