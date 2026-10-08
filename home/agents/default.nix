{
  inputs,
  pkgs,
  ...
}:
let
  llm-agents = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [
    ./herdr.nix
  ];

  home.packages = with llm-agents; [
    claude-code
    amp
  ];
}
