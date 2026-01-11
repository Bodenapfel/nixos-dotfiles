{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;

    # Imports env vars into systemd user session and provides hyprland-session.target
    # (default is true, keeping it explicit is fine)
    systemd.enable = true; # :contentReference[oaicite:5]{index=5}

    # Keep your config in Hyprland syntax (minimal migration pain)
    extraConfig = builtins.readFile ./hypr/hyprland.conf; # :contentReference[oaicite:6]{index=6}
  };

  #### Services you currently start via exec-once (make them declarative)
  services.gnome-keyring.enable = true;          # :contentReference[oaicite:8]{index=8}
  services.network-manager-applet.enable = true; # :contentReference[oaicite:9]{index=9}
  services.blueman-applet.enable = true;         # requires NixOS services.blueman.enable :contentReference[oaicite:10]{index=10}
  services.kdeconnect.enable = true;
  services.kdeconnect.indicator = true;          # :contentReference[oaicite:11]{index=11}
}

