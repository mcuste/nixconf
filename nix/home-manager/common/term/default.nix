{
  pkgs,
  lib,
  config,
  isStandalone,
  ...
}: {
  imports = [
    ./zellij.nix
  ];

  options.nixconf.term = {
    ghostty = pkgs.libExt.mkEnabledOption "ghostty";
    tmux = pkgs.libExt.mkEnabledOption "tmux";
  };

  config = let
    ghostty =
      if isStandalone
      then (config.lib.nixGL.wrap pkgs.ghostty)
      else pkgs.ghostty;
  in {
    programs.ghostty = lib.mkIf config.nixconf.term.ghostty {
      enable = true;
      package = ghostty;

      enableBashIntegration = true;
      enableFishIntegration = true;
    };

    home.packages = pkgs.libExt.filterNull [
      (pkgs.libExt.mkIfElseNull config.nixconf.term.tmux pkgs.tmux)
    ];
  };
}
