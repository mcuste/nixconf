{
  pkgs,
  lib,
  config,
  isStandalone,
  ...
}: {
  options.nixconf.term = {
    ghostty = pkgs.libExt.mkEnabledOption "ghostty";
    tmux = pkgs.libExt.mkEnabledOption "tmux";
    zellij = lib.mkEnableOption "zellij";
  };

  config = {
    home.packages = let
      ghostty =
        if isStandalone
        then (config.lib.nixGL.wrap pkgs.ghostty)
        else pkgs.ghostty;
    in
      pkgs.libExt.filterNull [
        (pkgs.libExt.mkIfElseNull config.nixconf.term.ghostty ghostty)
        (pkgs.libExt.mkIfElseNull config.nixconf.term.tmux pkgs.tmux)
        (pkgs.libExt.mkIfElseNull config.nixconf.term.zellij pkgs.zellij)
      ];
  };
}
