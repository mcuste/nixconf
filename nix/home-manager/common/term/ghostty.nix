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
          cursor-style-blink = false;
          window-padding-x = 5;
          window-padding-y = 5;
          window-padding-balance = true;
          window-decoration = "none";

          command = "fish";
          shell-integration-features = "no-cursor";

          keybind = [
            "ctrl+shift+c=copy_to_clipboard"
            "ctrl+shift+v=paste_from_clipboard"

            "ctrl+shift+e=write_scrollback_file:open"
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
