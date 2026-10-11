{
  inputs,
  pkgs,
  ...
}:
let
  amp = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.amp;
in
{
  services.amp-runner = {
    enable = true;
    package = amp;

    remoteControlTerminal = true;
    serveCwd = false;
  };
}
