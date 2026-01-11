{ config, pkgs, ... }:

{
  home.username = "dk";
  home.homeDirectory = "/home/dk";

  # Import files from the current configuration directory into the Nix store,
  # and create symbolic links pointing to those store files in the Home directory.

  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # Import the scripts directory into the Nix store,
  # and recursively generate symbolic links in the Home directory pointing to the files in the store.
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  imports = [
    ./shell/zsh.nix
    ./shell/tmux.nix
    ./rofi/rofi.nix
    ./theme/theme.nix
    ./window-manager/hyprland.nix
  ];


  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them

    # clipboard
    cliphist
    wl-clipboard

    # fonts
    nerd-fonts.comic-shanns-mono

    # Prompter and GUI manaager for gnome-keyring
    pkgs.gcr      # provides org.gnome.keyring.SystemPrompter
    pkgs.seahorse # GUI to inspect/edit keyrings

    # hyprland utils
    hypridle
    hyprshot
    hyprpaper
    hyprpolkitagent

    # display 
    brightnessctl
    ddcutil
    
    # misc
    kdePackages.kdeconnect-kde
    owncloud-client
    ferdium
    jellyfin-mpv-shim
    cowsay
    fortune
    sshfs

    # media
    mpv
    playerctl

    fastfetch

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

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils  # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc  # it is a calculator for the IPv4/v6 addresses

    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # productivity
    hugo # static site generator
    glow # markdown previewer in terminal

    btop  # replacement of htop/nmon
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

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    settings = {
      user.name = "Bodenapfel";
      user.email = "dakorb20@gmail.com";
      init.defaultbranch = "main";
    };
  };

  services.gnome-keyring = {
    enable = true;
    # Optional: restrict components, otherwise it starts a default set
    components = [ "secrets" "ssh" "pkcs11" ];
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.11";
}
