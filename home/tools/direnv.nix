{
  pkgs,
  lib,
  config,
  ...
}:
with pkgs.lib.conflib; let
  cfg = config.nixhome.tools;
in {
  options.nixhome.tools = {
    direnv = mkBoolOption {description = "Enable direnv";};
  };

  config = lib.mkIf cfg.direnv {
    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      # no need for fish integration, integrated by default
    };
  };
}
