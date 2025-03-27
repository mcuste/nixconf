{
  pkgs,
  lib,
  config,
  isStandalone,
  ...
}: {
  options.nixconf.term = {
    ghostty = pkgs.libExt.mkEnabledOption "ghostty";
  };

  config = let
    ghostty =
      if isStandalone
      then (config.lib.nixGL.wrap pkgs.ghostty)
      else pkgs.ghostty;
  in
    lib.mkIf config.nixconf.term.ghostty {
      programs.ghostty = {
        enable = true;
        package = ghostty;

        enableBashIntegration = true;
        enableFishIntegration = true;
      };
    };
}
