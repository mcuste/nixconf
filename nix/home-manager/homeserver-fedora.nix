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

      scripts = {
        enable = true;
        notes = false;
        systemd = false;
      };

      editor = {neovim = true;};

      media = {spotify = true;};

      packages = {
        kanata = true;
        protonvpn = true;
      };
    };
  };
}
