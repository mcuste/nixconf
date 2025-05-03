{
  pkgs,
  config,
  ...
}: let
  enable = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };
in {
  imports = [
    ./bash.nix
    ./aliases.nix
  ];

  options.nixconf.shell = {
    starship = pkgs.libExt.mkEnabledOption "Starship";

    fish = pkgs.libExt.mkEnabledOption "Fish";
  };

  config = {
    programs = {
      bat = {
        enable = true;
        extraPackages = with pkgs.bat-extras; [
          batgrep
          batman
          prettybat
        ];
      };

      dircolors = enable;

      direnv = builtins.removeAttrs enable ["enableFishIntegration"]; # fish integration enabled by default

      eza =
        enable
        // {
          git = true;
          icons = "auto";
        };

      fzf =
        enable
        // {
          tmux.enableShellIntegration = true;
          defaultCommand = "${pkgs.fd}/bin/fd --type f";
          fileWidgetCommand = "${pkgs.fd}/bin/fd --type f";
          fileWidgetOptions = [
            "--preview '${pkgs.bat}/bin/bat --style=numbers --color=always --line-range :500 {}'"
          ];
          changeDirWidgetCommand = "${pkgs.fd}/bin/fd --type d";
          changeDirWidgetOptions = ["--preview '${pkgs.tree}/bin/tree -C {} | head -200'"];
        };

      yazi =
        enable
        // {
          keymap = {};
          settings = {};
        };

      zoxide = enable;

      starship =
        enable
        // {
          settings = {
            scan_timeout = 10;
            add_newline = true;
            # format = "$all"; # Disable default prompt format
            battery = {disabled = true;};
            fill = {disabled = true;};
          };
        };

      fish = {
        enable = true;
        shellInit = ''
          set fish_greeting # Disable greeting
          fish_vi_key_bindings
          set fish_cursor_default block
          set fish_cursor_insert block
          set fish_cursor_visual block

          test -r /home/${config.nixconf.username}/.nix-profile/etc/profile.d/nix.sh && source /home/${config.nixconf.username}/.nix-profile/etc/profile.d/nix.sh > /dev/null 2> /dev/null; or true
          test -r /home/${config.nixconf.username}/.opam/opam-init/init.fish && source /home/${config.nixconf.username}/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
        '';
      };

      # fish wants to generate man cache for every lang for no reason...
      man.generateCaches = false;
    };

    home.packages = [
      pkgs.aider-chat
    ];
  };
}
