{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    fd
    ripgrep
    gh
  ];
}
