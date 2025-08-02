{
  pkgs,
  lib,
  config,
  isStandalone,
  ...
}: {
  options.nixconf.editor = {
    neovim = pkgs.libExt.mkEnabledOption "neovim";
    obsidian = lib.mkEnableOption "Obsidian";
    vscode = lib.mkEnableOption "VSCode";
    zed = lib.mkEnableOption "Zed";
    pycharm-professional = lib.mkEnableOption "PyCharm Professional";
  };

  config = let
    zed-editor =
      if isStandalone
      then (config.lib.nixGL.wrap pkgs.zed-editor)
      else pkgs.zed-editor;
  in {
    home.packages = pkgs.libExt.filterNull [
      (pkgs.libExt.mkIfElseNull config.nixconf.editor.obsidian pkgs.obsidian)
      (pkgs.libExt.mkIfElseNull config.nixconf.editor.vscode pkgs.vscode)
      (pkgs.libExt.mkIfElseNull config.nixconf.editor.zed zed-editor)
      (pkgs.libExt.mkIfElseNull config.nixconf.editor.pycharm-professional pkgs.jetbrains.pycharm-professional)
    ];

    # Config via stow
    programs = lib.mkIf config.nixconf.editor.neovim {
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
