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
