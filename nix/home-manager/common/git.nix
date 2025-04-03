{
  pkgs,
  lib,
  config,
  ...
}: {
  options.nixconf.git = {
    enable = pkgs.libExt.mkEnabledOption "git";

    gitUsername = lib.mkOption {
      type = lib.types.str;
      default = "mcuste";
      description = "Git username";
    };

    gitEmail = lib.mkOption {
      type = lib.types.str;
      default = "github@muratcanuste.com";
      description = "Git email";
    };

    graphite = lib.mkEnableOption "Graphite CLI";
  };

  config = let
    shellAliases = {
      g = "git";
      lg = "lazygit";
    };
  in
    lib.mkIf config.nixconf.git.enable {
      programs.bash = {inherit shellAliases;};
      programs.fish = {inherit shellAliases;};

      home.packages = pkgs.libExt.filterNull [
        pkgs.git
        pkgs.delta
        pkgs.lazygit
        pkgs.gh
        pkgs.gh-dash

        (pkgs.libExt.mkIfElseNull config.nixconf.git.graphite pkgs.graphite-cli)
      ];
    };
}
