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

      programs.git = {
        enable = true;
        lfs.enable = true;
        delta.enable = true;
        userName = config.nixconf.git.gitUsername;
        userEmail = config.nixconf.git.gitEmail;
        extraConfig = {
          core = {
            whitespace = "trailing-space,space-before-tab";
            editor = "nvim";
          };
        };
        ignores = [
          # things that will be ignored always
          ".direnv"
          ".aider*"
        ];
        aliases = {
          s = "status";
          a = "add";
          aa = "add --all";
          p = "pull";
          ps = "push";
          c = "commit";
          cm = "commit -m";
          cl = "clone";
          b = "branch";
          co = "checkout";
          cob = "checkout -b";
          r = "rebase";
          re = "restore";
          res = "restore --staged";
          d = "diff";
          clb = "clone --bare";
          wl = "worktree list";
          wa = "worktree add";
          wr = "worktree remove";
          wrf = "worktree remove --force";
        };
      };

      programs.gh = {
        enable = true;
        extensions = [pkgs.gh-copilot];
      };

      programs.gh-dash.enable = true;

      programs.lazygit.enable = true;

      home.packages = pkgs.libExt.filterNull [
        (pkgs.libExt.mkIfElseNull config.nixconf.git.graphite pkgs.graphite-cli)
      ];
    };
}
