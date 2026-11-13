{
  perSystem =
    { pkgs, ... }:
    {
      packages.jj-hunk = pkgs.callPackage ../pkgs/jj-hunk { };
    };
}
