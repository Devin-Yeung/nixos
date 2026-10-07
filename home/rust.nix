{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    rustup
    cargo-binstall
    cargo-insta
    cargo-nextest
  ];

  programs.cargo = {
    enable = true;
    package = pkgs.rustup; # use rustup's cargo
  };
}
