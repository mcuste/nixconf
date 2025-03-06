{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  options.nixconf.editor.neovim = pkgs.libExt.mkEnabledOption "neovim";

  config = lib.mkIf config.nixconf.editor.neovim {
    home.packages = [
      pkgs.wl-clipboard # install wayland clipboard tool
    ];

    programs = let
      shellAliases = {
        v = "nvim";
      };
    in {
      bash = {inherit shellAliases;};
      fish = {inherit shellAliases;};

      neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;
        defaultEditor = true;
        withNodeJs = true;

        extraLuaPackages = ps: [
          pkgs.lua51Packages.luarocks
          ps.tiktoken_core
        ];

        extraPackages = [
          pkgs.tree-sitter
          pkgs.nixd
        ];
      };
    };
  };
}
