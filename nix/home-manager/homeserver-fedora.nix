{
  imports = [
    ./common
  ];

  config = {
    nixconf = rec {
      username = "homeserver";
      stateVersion = "24.11";
      flakePath = "/home/${username}/nixconf";

      git.graphite = true;

      editor = {neovim = true;};

      media = {spotify = true;};

      packages = {
        kanata = true;
        protonvpn = true;
      };
    };
  };
}
