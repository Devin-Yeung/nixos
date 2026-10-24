{
  config,
  lib,
  pkgsNightly,
  ...
}:
{
  programs.go = {
    enable = true;
    package = pkgsNightly.go;
    env = {
      GOPATH = [
        "${config.home.homeDirectory}/.go"
      ];
      GOTOOLCHAIN = "local";
    };
  };

  # Derive PATH from the resolved GOPATH so the two cannot drift apart.
  # `go install` binaries land in the first GOPATH entry's bin/ (GOBIN unset).
  home.sessionPath = map (p: "${p}/bin") (lib.splitString ":" config.programs.go.env.GOPATH);

  home.packages = with pkgsNightly; [
    gopls
    golangci-lint
    gow
    gotestsum # Test runner with better output formatting
    air # Live reloading for Go development
  ];
}
