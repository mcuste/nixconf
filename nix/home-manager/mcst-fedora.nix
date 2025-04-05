{
  imports = [
    ./common
  ];

  config = {
    nixconf = rec {
      username = "mcst";
      stateVersion = "24.11";
      flakePath = "/home/${username}/nixconf";

      git.graphite = true;

      chat.slack = true;

      editor = {
        neovim = true;
        obsidian = true;
        vscode = true;
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
        k3d = true;
        helm = true;
        argo = true;
      };
    };
  };
}
