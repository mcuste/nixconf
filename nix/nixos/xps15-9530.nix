{
  imports = [
    ./common
    ./processor/intel-cpu.nix
    ./processor/intel-igpu.nix
    ./processor/nvidia.nix
  ];

  config = {
    nixconf = {
      username = "mcst";
      hostname = "nixos";
      stateVersion = "24.11";

      gaming.enable = true;

      nvidia = {
        enable = true;
        isTuring = true;
        sync = false; # use offload, sync causes issues with wayland and browsers
      };

      virtualisation = {
        docker = {
          enable = true;
          autoPrune = true;
        };
        podman = {
          enable = false;
          dockerCompat = false;
        };
      };
    };
  };
}
