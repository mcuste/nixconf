{
  pkgs,
  lib,
  config,
  ...
}: {
  options.nixconf.browsers = {
    brave = lib.mkEnableOption "Brave";
    chrome = lib.mkEnableOption "Chrome";
    firefox = lib.mkEnableOption "Firefox";
  };

  config = {
    home.packages = pkgs.libExt.filterNull [
      (pkgs.libExt.mkIfElseNull config.nixconf.browsers.brave pkgs.stable.brave)
      (pkgs.libExt.mkIfElseNull config.nixconf.browsers.chrome pkgs.stable.google-chrome)
      (pkgs.libExt.mkIfElseNull config.nixconf.browsers.firefox pkgs.stable.firefox)
    ];
  };
}
