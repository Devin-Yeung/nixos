{
  config,
  lib,
  pkgs,
  osConfig ? null,
  ...
}:
let
  inherit (lib)
    mkIf
    mkOption
    types
    optional
    ;

  cfg = config.services.amp-runner;

  args = [
    "--no-tui"
  ]
  ++ optional (cfg.runnerId != null) "--runner-id=${cfg.runnerId}"
  ++ optional cfg.remoteControlTerminal "--remote-control-terminal"
  ++ optional (!cfg.serveCwd) "--no-serve-cwd"
  ++ map (dir: "--discover-dirs=${dir}") cfg.discoverDirs
  ++ cfg.extraArgs;

in
{
  options.services.amp-runner = {
    enable = lib.mkEnableOption "the Amp `--no-tui` runner as a systemd user service";

    package = mkOption {
      type = types.package;
      description = "The amp package to run.";
    };

    runnerId = mkOption {
      type = types.nullOr types.str;
      default = if osConfig != null then osConfig.networking.hostName else null;
      defaultText = lib.literalExpression "config.networking.hostName (NixOS only)";
      description = ''
        Stable runner ID passed as `--runner-id`. Defaults to the NixOS
        `networking.hostName`; it must be set explicitly when that is not available.
      '';
    };

    remoteControlTerminal = mkOption {
      type = types.bool;
      default = false;
      description = "Enable terminal access from ampcode.com (`--remote-control-terminal`).";
    };

    serveCwd = mkOption {
      type = types.bool;
      default = true;
      description = "Serve the working directory. When false, passes `--no-serve-cwd`.";
    };

    discoverDirs = mkOption {
      type = types.listOf types.str;
      default = [ "%h/.local/share/amp-runner/projects" ];
      description = ''
        Directories to discover projects in, passed as `--discover-dirs=<dir>`.
        Defaults to `$XDG_DATA_HOME/amp-runner/projects`, created automatically.
        Relative paths resolve against `workingDirectory`.
      '';
    };

    workingDirectory = mkOption {
      type = types.str;
      default = "%S/amp-runner";
      description = ''
        Working directory of the runner process. The default is a state directory
        (`~/.local/state/amp-runner`), created by systemd via `StateDirectory`.
      '';
    };

    extraArgs = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "Additional arguments appended to `amp --no-tui`.";
    };

    extraPackages = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = "Extra packages made available on the runner's PATH.";
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.runnerId != null;
        message = "services.amp-runner.runnerId must be set when no NixOS networking.hostName is available.";
      }
    ];

    systemd.user.services.amp-runner = {
      Unit = {
        Description = "Amp --no-tui runner";
        StartLimitIntervalSec = 0;
      };

      Service = {
        ExecStart = lib.escapeShellArgs ([ "${cfg.package}/bin/amp" ] ++ args);
        StateDirectory = "amp-runner";
        WorkingDirectory = cfg.workingDirectory;
        ExecStartPre = lib.escapeShellArgs (
          [
            "${pkgs.coreutils}/bin/mkdir"
            "-p"
          ]
          ++ cfg.discoverDirs
        );
        Environment = [
          "PATH=${
            lib.makeBinPath (
              [
                "/run/wrappers"
                config.home.path
              ]
              ++ cfg.extraPackages
            )
          }:/run/current-system/sw/bin"
        ];
        Restart = "on-failure";
        RestartSec = 5;
      };

      Install.WantedBy = [ "default.target" ];
    };
  };
}
