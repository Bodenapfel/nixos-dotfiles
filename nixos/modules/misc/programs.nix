{
  pkgs,
  pkgs-unstable,
  config,
  lib,
  ...
}:

{
  options = {
    programs.enable = lib.mkEnableOption "enable miscellaneous programs";
  };

  config = lib.mkIf config.programs.enable {
    environment.systemPackages = with pkgs; [
      # for codex
      bubblewrap
      file-roller
      wget
      vim
      pkgs-unstable.neovim
      ncdu
      clang
      cmake
      gnumake
      gcc
      nixpkgs-fmt
      nil
      pkg-config
      nodejs
      jdk21
      jdk17
      jdk8
      python3
      lua
      rustup
      markdownlint-cli
      pkgs-unstable.lact
      sbctl
      ddcutil
      brightnessctl
      efibootmgr
      bash
      i2c-tools
      pkgs-unstable.protonup-qt
      pkgs-unstable.protontricks
      pkgs-unstable.gamescope
      wineWow64Packages.stable
      winetricks
      wireguard-tools
      networkmanagerapplet
      libsForQt5.qtkeychain
      libva
      libva-utils
      glib
      xdg-utils
      libsecret
      tldr
      xclip
      xsel
      wl-clipboard
      wl-clip-persist
      cliphist
      cifs-utils
      # davfs2 # broken build in current nixpkgs
      gh # github cli
      # kdePackages.kwallet
      # kdePackages.kwalletmanager
    ];

    programs.dconf = {
      enable = true;
    };

    programs.nix-ld.enable = true;

    programs.seahorse.enable = true;

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
      package = pkgs-unstable.steam;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = true;
      extraCompatPackages = [ pkgs-unstable.proton-ge-bin ];
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
  };
}
