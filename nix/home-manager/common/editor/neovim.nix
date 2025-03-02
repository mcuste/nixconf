{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./neovim
  ];

  options.nixconf.editor.neovim = pkgs.libExt.mkEnabledOption "neovim";

  config = lib.mkIf config.nixconf.editor.neovim {
    programs = let
      shellAliases = {
        v = "nvim";
      };
    in {
      bash = {inherit shellAliases;};
      fish = {inherit shellAliases;};
      nixvim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;

        globals = {
          mapleader = " ";
          maplocalleader = "\\";
          markdown_recommended_style = 0; # Fix markdown indentation settings
        };
      };
    };

    home.file.".local/share/applications/nvim-ghostty.desktop" = let
      # weird treesitter bug when writing `text=''''`
      entry = ''
        [Desktop Entry]
        Name=Neovim
        Categories=Utility;TextEditor;
        Comment=Neovim Text Editor
        Exec=ghostty -e nvim %F
        Icon=gvim
        Keywords=Text;editor;
        MimeType=text/english;text/plain;text/x-makefile;text/x-c++hdr;text/x-c++src;text/x-chdr;text/x-csrc;text/x-java;text/x-moc;text/x-pascal;text/x-tcl;text/x-tex;application/x-shellscript;text/x-c;text/x-c++;
        StartupNotify=false
        Terminal=false
        Type=Application
      '';
    in {
      recursive = true;
      text = entry;
    };

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = ["brave-browser.desktop"];
        "x-scheme-handler/http" = ["brave-browser.desktop"];
        "x-scheme-handler/https" = ["brave-browser.desktop"];
        "x-scheme-handler/about" = ["brave-browser.desktop"];
        "x-scheme-handler/unknown" = ["brave-browser.desktop"];
        "text/plain" = ["nvim-ghostty.desktop"];
      };
    };
  };
}
