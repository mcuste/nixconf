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
      else pkgs.alacritty;
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

            "alt+a>r=reload_config"
            "alt+a>\\=toggle_window_decorations"

            "alt+a>e=write_scrollback_file:open"
            "alt+ctrl+l=clear_screen"

            "alt+a>q=close_window"
            "alt+a>c=new_tab"
            "alt+a>v=new_split:right"
            "alt+a>s=new_split:down"

            "alt+shift+zero=reset_font_size"
            "alt+shift+minus=decrease_font_size:1"
            "alt+shift+plus=increase_font_size:1"

            "alt+shift+up=resize_split:up,10"
            "alt+shift+down=resize_split:down,10"
            "alt+shift+right=resize_split:right,10"
            "alt+shift+left=resize_split:left,10"

            "ctrl+h=goto_split:left"
            "ctrl+l=goto_split:right"
            "ctrl+j=goto_split:down"
            "ctrl+k=goto_split:up"

            "alt+a>h=previous_tab"
            "alt+a>l=next_tab"
          ];
        };
      };
    };
}
