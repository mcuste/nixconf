{
  # Config via stow
  programs = let
    shellAliases = {
      g = "git";
      lg = "lazygit";
      v = "nvim";
      k = "kubectl";
    };
  in {
    bash = {inherit shellAliases;};
    fish = {inherit shellAliases;};
  };
}
