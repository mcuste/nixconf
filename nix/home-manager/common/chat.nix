{
  pkgs,
  lib,
  config,
  ...
}: {
  options.nixconf.chat = {
    slack = lib.mkEnableOption "Slack";
    discord = lib.mkEnableOption "Discord";
  };

  config = {
    home.packages = pkgs.libExt.filterNull [
      (pkgs.libExt.mkIfElseNull config.nixconf.chat.slack pkgs.slack)
      (pkgs.libExt.mkIfElseNull config.nixconf.chat.discord pkgs.stable.discord)
    ];
  };
}
