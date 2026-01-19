{ config, pkgs, ... }:
{
  # openrgb
  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb-with-all-plugins;
    motherboard = "amd";
  };

  # for thunar
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  # flatpak
  services.flatpak.enable = true;

  # gnome keyring
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

  # Needed for aut dialogs
  security.polkit.enable = true;
}
