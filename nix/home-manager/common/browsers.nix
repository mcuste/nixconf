{
  pkgs,
  lib,
  config,
  ...
}: {
  options.nixconf.browsers = {
    zen = lib.mkEnableOption "Zen";
    chrome = lib.mkEnableOption "Chrome";
    firefox = lib.mkEnableOption "Firefox";
  };

  config = {
    home.packages = pkgs.libExt.filterNull [
      (pkgs.libExt.mkIfElseNull config.nixconf.browsers.zen pkgs.stable.zen-browser)
      (pkgs.libExt.mkIfElseNull config.nixconf.browsers.chrome pkgs.stable.google-chrome)
      (pkgs.libExt.mkIfElseNull config.nixconf.browsers.firefox pkgs.stable.firefox)
    ];
  };
}
