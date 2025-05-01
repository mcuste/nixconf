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
    godot = lib.mkEnableOption "Godot 4";
    vscode = lib.mkEnableOption "VSCode";
    rust-rover = lib.mkEnableOption "RustRover";
    pycharm-professional = lib.mkEnableOption "PyCharm Professional";
  };

  config = let
    godot4 =
      if isStandalone
      then (config.lib.nixGL.wrap pkgs.godot_4)
      else pkgs.godot_4;
  in {
    home.packages = pkgs.libExt.filterNull [
      (pkgs.libExt.mkIfElseNull config.nixconf.editor.obsidian pkgs.obsidian)
      (pkgs.libExt.mkIfElseNull config.nixconf.editor.godot godot4)
      (pkgs.libExt.mkIfElseNull config.nixconf.editor.vscode pkgs.vscode)
      (pkgs.libExt.mkIfElseNull config.nixconf.editor.pycharm-professional pkgs.jetbrains.pycharm-professional)
      (pkgs.libExt.mkIfElseNull config.nixconf.editor.rust-rover pkgs.jetbrains.rust-rover)
    ];

    # Config via stow
    programs = let
      shellAliases = {
        v = "nvim";
      };
    in
      lib.mkIf config.nixconf.editor.neovim {
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
