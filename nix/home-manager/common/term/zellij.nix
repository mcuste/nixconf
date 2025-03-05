{
  pkgs,
  lib,
  config,
  ...
}: {
  options.nixconf.term = {
    zellij = pkgs.libExt.mkEnabledOption "zellij";
  };

  config = lib.mkIf config.nixconf.term.zellij {
    programs.zellij = let
      shell =
        if config.nixconf.shell.fish
        then "${pkgs.fish}/bin/fish"
        else "${pkgs.bash}/bin/bash";
    in {
      enable = true;
      enableBashIntegration = false;
      enableFishIntegration = false;
    };
  };
}
