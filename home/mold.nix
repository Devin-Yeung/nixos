{ pkgsNightly, ... }:
{
  programs.mold = {
    enable = true;
    package = pkgsNightly.mold;
  };
}
