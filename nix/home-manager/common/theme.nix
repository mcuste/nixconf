{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  options.nixconf.theme = {
    font = lib.mkOption {
      type = lib.types.str;
      default = "JetBrainsMono";
      description = "Main font";
    };

    flavor = lib.mkOption {
      type = lib.types.str;
      default = "mocha";
      description = "Catppuccin flavor";
    };

    accent = lib.mkOption {
      type = lib.types.str;
      default = "blue";
      description = "Catppuccin accent";
    };
  };

  config = {
    catppuccin = {
      flavor = config.nixconf.theme.flavor;
      accent = config.nixconf.theme.accent;
      starship.enable = true;
      fish.enable = true;
      bat.enable = true;
    };
  };
}
