{
  config,
  pkgsNightly,
  ...
}:
let
  go_path = "${config.home.homeDirectory}/.go";
in
{
  home = {
    sessionVariables = {
      GOPATH = go_path;
    };
    sessionPath = [
      "${go_path}/bin"
    ];
    packages = with pkgsNightly; [
      go
      gopls
      golangci-lint
      gotestsum # Test runner with better output formatting
      air # Live reloading for Go development
    ];
  };
}
