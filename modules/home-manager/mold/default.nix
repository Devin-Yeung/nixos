{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf mkOption types;

  cfg = config.programs.mold;
  triple = pkgs.stdenv.hostPlatform.rust.rustcTargetSpec;
in
{
  options.programs.mold = {
    enable = mkEnableOption "mold linker";

    package = mkOption {
      type = types.package;
      default = inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.mold;
      defaultText = lib.literalExpression "inputs.self.packages.\${system}.mold";
      description = "The mold package. Its `ld.mold` symlink is put on PATH for `-fuse-ld=mold`.";
    };

    enableCargoIntegration = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Use mold as the default linker for Cargo/rustc by adding
        `-C link-arg=-fuse-ld=mold` to the host target's rustflags in
        `~/.cargo/config.toml`.
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    # Only the host target is affected; build scripts and proc macros follow the same target.
    programs.cargo.settings = mkIf cfg.enableCargoIntegration {
      target.${triple}.rustflags = [
        "-C"
        "link-arg=-fuse-ld=mold"
      ];
    };
  };
}
