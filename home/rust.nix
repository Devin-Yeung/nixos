{
  config,
  pkgs,
  lib,
  ...
}:
let
  cargoHome = config.home.sessionVariables.CARGO_HOME or "${config.home.homeDirectory}/.cargo";
in
{
  home.packages = with pkgs; [
    cargo-binstall
    cargo-insta
    cargo-nextest
  ];

  # Reuse Cargo's configured home, falling back to its default; prioritize its shims.
  home.sessionPath = lib.mkBefore [ "${cargoHome}/bin" ];

  programs.cargo = {
    enable = true;
    package = pkgs.rustup; # use rustup's cargo
  };
}
