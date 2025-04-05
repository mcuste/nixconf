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

      editor = {
        vscode = false;
        obsidian = true;
        pycharm-professional = false;
        rust-rover = false;
        godot = true;
      };

      browsers = {
        brave = true;
        chrome = true;
        firefox = true;
      };

      media = {
        spotify = true;
        calibre = true;
        zotero = true;
      };

      chat.slack = true;

      packages = {
        packer = true;
        terraform = true;
        gcloud = true;
        kubectl = true;
        k9s = true;
        k3d = true;
        helm = true;
        argo = true;
        dive = true;
      };
    };
  };
}
