{
  config,
  pkgs,
  pkgsNightly,
  ...
}:
let
  settings = {
    # https://pnpm.io/settings#minimumreleaseage
    # 7 days in minutes (npm uses days, pnpm uses minutes, bun uses seconds)
    minimumReleaseAge = 7 * 24 * 60;
  };

  format = pkgs.formats.yaml { };
in
{
  home.packages = [
    pkgsNightly.pnpm
  ];

  home.sessionVariables = {
    PNPM_HOME = "${config.xdg.dataHome}/pnpm";
  };

  # `pnpm add -g` links global binaries into ~/.local/share/pnpm/bin
  home.sessionPath = [
    "${config.xdg.dataHome}/pnpm/bin"
  ];

  # check `pnpm config list --location=global`
  xdg.configFile."pnpm/config.yaml".source = format.generate "config.yaml" settings;
}
