{ pkgs, pkgs-stable, ... }:

{
  programs = {
    firefox.enable = true;
    git = {
      enable = true;
      settings = {
        user.name = "Bodenapfel";
        user.email = "dakorb20@gmail.com";
        init.defaultbranch = "main";
      };
    };
  };

  home.packages = with pkgs; [

    # communication
    vesktop
    teamspeak6-client
    ferdium

    # clipboard
    cliphist
    wl-clipboard

    # hyprland utils
    hyprshot
    hyprpolkitagent
    hyprpaper
    hypridle
    hyprsunset

    # multimedia
    playerctl
    pavucontrol
    helvum
    jellyfin-mpv-shim
    qview
    gimp
    krita

    # gui apps
    blueman
    wootility
    qbittorrent
    onlyoffice-desktopeditors
    kdePackages.kdeconnect-kde
    pkgs-stable.owncloud-client # unstable has wrong hash
    obs-studio
    ffmpeg

    # misc
    fortune
    cowsay
    sshfs
    swaynotificationcenter
    libnotify
    anki
    gnused
    gnupg
    gnutar
    gawk
    zstd
    gcr
    cmatrix
    cava

    # vpn
    protonvpn-gui # ProtonVPN GUI client

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder
    which # shows the full path of (shell) commands
    tree # display directories as trees
    file # determine file type

    # networking tools
    mtr # A network diagnostic tool
    iperf3 # network bandwidth measurement tool
    dnsutils # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc # it is a calculator for the IPv4/v6 addresses

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # productivity
    hugo # static site generator
    glow # markdown previewer in terminal

    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
  ];
}
