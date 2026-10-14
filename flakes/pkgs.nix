{
  perSystem =
    { pkgs, ... }:
    {
      packages.mold = pkgs.callPackage ../pkgs/mold { };
    };
}
