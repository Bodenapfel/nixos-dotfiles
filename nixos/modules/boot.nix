{ config, pkgs, lib, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.timeout = 10;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.consoleMode = "max";
  boot.loader.systemd-boot.configurationLimit = 5;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.udev.packages = [ pkgs.openrgb pkgs.wooting-udev-rules ];
}
