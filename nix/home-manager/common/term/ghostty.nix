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

        installVimSyntax = true;
        installBatSyntax = true;

        clearDefaultKeybinds = true;

        settings = {
          theme = "catppuccin-mocha";
          font-size = 12;
          font-family = "${config.nixconf.theme.font} Nerd Font";
          cursor-style = "block";
          cursor-style-blink = false;
          # cursor-invert-fg-bg = true;
          cursor-text = "#000000";
          window-padding-x = 5;
          window-padding-y = 5;
          window-padding-balance = true;
          window-decoration = "none";

          command = "tmux attach || tmux";
          shell-integration-features = "no-cursor";

          keybind = [
            "ctrl+shift+c=copy_to_clipboard"
            "ctrl+shift+v=paste_from_clipboard"
            "ctrl+shift+l=clear_screen"

            "ctrl+shift+zero=reset_font_size"
            "ctrl+shift+minus=decrease_font_size:1"
            "ctrl+shift+plus=increase_font_size:1"

            "ctrl+shift+r=reload_config"
            "ctrl+shift+\\=toggle_window_decorations"
          ];
        };
      };
    };
}
