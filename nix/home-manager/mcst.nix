{
  imports = [
    ./common
  ];

  config = {
    nixconf = rec {
      username = "mcst";
      stateVersion = "24.11";
      flakePath = "/home/${username}/nixconf";

      term.ghostty = true;

      git.graphite = true;

      chat.slack = true;

      editor = {
        neovim = true;
        obsidian = true;
      };

      media = {
        spotify = true;
      };

      packages = {
        kanata = true;
        protonvpn = true;
        terraform = true;
        gcloud = true;
        kubectl = true;
        k9s = true;
        k3d = false; # using pre-built bin v5.6.3 as anything above 5.7 are broken
        helm = true;
        argo = true;
        fluxcd = true;
        lazydocker = true;
        cargo-nextest = true;
        anki = true;
        gemini-cli = true;
      };
    };
  };
}
