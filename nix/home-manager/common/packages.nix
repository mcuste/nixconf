{
  pkgs,
  lib,
  config,
  ...
}: {
  options.nixconf.packages = {
    # Keyboard config, only used in non NixOS systems
    kanata = lib.mkEnableOption "Kanata";

    # VPN
    protonvpn = lib.mkEnableOption "ProtonVPN";

    # Container related packages (system level packages are set either in NixOS or via system packages on other distros)
    podman-compose = lib.mkEnableOption "Podman Compose";
    nerdctl = lib.mkEnableOption "Nerdctl";
    lazydocker = lib.mkEnableOption "Lazydocker";
    dive = lib.mkEnableOption "Dive";

    # K8s
    kubectl = lib.mkEnableOption "Kubectl";
    k9s = lib.mkEnableOption "K9s";
    k3d = lib.mkEnableOption "K3d";
    helm = lib.mkEnableOption "Helm";

    # Cloud
    aws = lib.mkEnableOption "AWS CLI";
    azure = lib.mkEnableOption "Azure CLI";
    cfssl = lib.mkEnableOption "CFSSL";
    digital-ocean = lib.mkEnableOption "Digital Ocean CLI";
    gcloud = lib.mkEnableOption "Google Cloud CLI";
    localstack = lib.mkEnableOption "Localstack CLI";

    # IaC
    cosign = lib.mkEnableOption "Cosign";
    packer = lib.mkEnableOption "Packer";
    terraform = lib.mkEnableOption "Terraform";

    # CI/CD
    argo = lib.mkEnableOption "Argo CLI";
    argocd = lib.mkEnableOption "ArgoCD CLI";
    fluxcd = lib.mkEnableOption "FluxCD CLI";

    # Rust
    cargo-nextest = lib.mkEnableOption "Cargo Nextest";
  };

  config = {
    home.packages = pkgs.libExt.filterNull [
      # must haves
      pkgs.lsof
      pkgs.lshw
      pkgs.pciutils
      pkgs.unzip
      pkgs.unrar-free
      pkgs.rsync
      pkgs.fd
      pkgs.ripgrep
      pkgs.ncdu
      pkgs.jq
      pkgs.traceroute
      pkgs.hyperfine
      pkgs.entr
      pkgs.ffmpegthumbnailer
      pkgs.just
      pkgs.fastfetch
      pkgs.htop
      pkgs.bottom
      pkgs.stow
      pkgs.tokei
      pkgs.wl-clipboard # install wayland clipboard tool

      # Keyboard
      (pkgs.libExt.mkIfElseNull config.nixconf.packages.kanata pkgs.kanata)

      # VPN
      (pkgs.libExt.mkIfElseNull config.nixconf.packages.protonvpn pkgs.stable.protonvpn-gui)

      # Containers
      (pkgs.libExt.mkIfElseNull config.nixconf.packages.podman-compose pkgs.podman-compose)
      (pkgs.libExt.mkIfElseNull config.nixconf.packages.nerdctl pkgs.nerdctl)
      (pkgs.libExt.mkIfElseNull config.nixconf.packages.lazydocker pkgs.lazydocker)
      (pkgs.libExt.mkIfElseNull config.nixconf.packages.dive pkgs.dive)

      # K8s
      (pkgs.libExt.mkIfElseNull config.nixconf.packages.kubectl pkgs.kubectl)
      (pkgs.libExt.mkIfElseNull config.nixconf.packages.k9s pkgs.k9s)
      (pkgs.libExt.mkIfElseNull config.nixconf.packages.k3d pkgs.k3d)
      (pkgs.libExt.mkIfElseNull config.nixconf.packages.helm pkgs.kubernetes-helm)

      # Cloud
      (pkgs.libExt.mkIfElseNull config.nixconf.packages.aws pkgs.awscli2)
      (pkgs.libExt.mkIfElseNull config.nixconf.packages.azure pkgs.azure-cli)
      (pkgs.libExt.mkIfElseNull config.nixconf.packages.cfssl pkgs.cfssl)
      (pkgs.libExt.mkIfElseNull config.nixconf.packages.digital-ocean pkgs.doctl)
      (pkgs.libExt.mkIfElseNull config.nixconf.packages.localstack pkgs.localstack)
      (pkgs.libExt.mkIfElseNull config.nixconf.packages.gcloud (
        pkgs.google-cloud-sdk.withExtraComponents [
          pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin
          pkgs.google-cloud-sdk.components.kubectl-oidc
          pkgs.google-cloud-sdk.components.terraform-tools
          pkgs.google-cloud-sdk.components.docker-credential-gcr
        ]
      ))

      # IaC
      (pkgs.libExt.mkIfElseNull config.nixconf.packages.cosign pkgs.cosign)
      (pkgs.libExt.mkIfElseNull config.nixconf.packages.packer pkgs.packer)
      (pkgs.libExt.mkIfElseNull config.nixconf.packages.terraform pkgs.terraform)

      # CI/CD
      (pkgs.libExt.mkIfElseNull config.nixconf.packages.argo pkgs.argo)
      (pkgs.libExt.mkIfElseNull config.nixconf.packages.argocd pkgs.argocd)
      (pkgs.libExt.mkIfElseNull config.nixconf.packages.fluxcd pkgs.fluxcd)

      # Rust
      (pkgs.libExt.mkIfElseNull config.nixconf.packages.cargo-nextest pkgs.cargo-nextest)
    ];
  };
}
