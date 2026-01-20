{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    file-roller
    wget
    vim
    neovim
    vesktop
    ncdu
    clang
    cmake
    gnumake
    gcc
    nixpkgs-fmt
    pkg-config
    nodejs_25
    jdk21
    jdk17
    jdk8
    python3
    rustup
    markdownlint-cli
    lact
    sbctl
    ddcutil
    brightnessctl
    efibootmgr
    bash
    i2c-tools
    protonup-qt
    protontricks
    gamescope
    wineWowPackages.stable
    winetricks
    wireguard-tools
    networkmanagerapplet
    owncloud-client
    libsForQt5.qtkeychain
    xdg-desktop-portal
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    libva
    libva-utils
    glib
    xdg-utils
  ];

  programs.dconf.enable = true;

  programs.nix-ld.enable = true;

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  programs.yazi.enable = true;
  programs.zsh.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };
  programs.gamemode.enable = true;

  programs.xfconf.enable = true;

  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
      thunar-media-tags-plugin
      thunar-vcs-plugin
      thunar-volman
    ];
  };
}
