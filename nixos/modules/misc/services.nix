{
  pkgs,
  config,
  lib,
  ...
}:

{
  options = {
    services.enable = lib.mkEnableOption "enable miscellaneous services";
  };

  config = lib.mkIf config.services.enable {
    # for thunar
    services.gvfs.enable = true; # Mount, trash, and other functionalities
    services.tumbler.enable = true; # Thumbnail support for images

    # flatpak
    services.flatpak.enable = true;

    # gnome keyring
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.login.enableGnomeKeyring = true;

    # kde wallet
    # security.pam.services.login.kwallet = {
    #   enable = true;
    #   package = pkgs.kdePackages.kwallet-pam;
    # };

    # Needed for aut dialogs
    security.polkit.enable = true;

    # udev rules
    services.udev.packages = [
      pkgs.wooting-udev-rules
    ];

    services.dbus.enable = true;

    # davfs2 disabled: broken build in current nixpkgs (missing m4 dir in autoreconf)
    # services.davfs2.enable = true;

  };
}
