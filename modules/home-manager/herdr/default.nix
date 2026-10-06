{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkOption types;

  cfg = config.programs.herdr;

  tomlFormat = pkgs.formats.toml { };
in
{
  options.programs.herdr = {
    enable = lib.mkEnableOption "herdr";

    package = lib.mkPackageOption pkgs "herdr" { };

    settings = mkOption {
      type = types.attrs;
      default = { };
      description = "herdr configuration written to ~/.config/herdr/config.toml";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
    xdg.configFile."herdr/config.toml".source = tomlFormat.generate "herdr-config" cfg.settings;
  };
}
