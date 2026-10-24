{ inputs, pkgs, ... }:
let
  grok-bot = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.grok-bot;
in
{
  home.packages = [
    grok-bot
  ];
}
