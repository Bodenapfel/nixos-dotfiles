{ pkgs, config, lib, ... }:

{
  options = { boot.enable = lib.mkEnableOption "enable boot configuration"; };

  config = lib.mkIf config.boot.enable {
    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = lib.mkForce false;
    boot.loader.systemd-boot.consoleMode = "auto";
    boot.loader.systemd-boot.configurationLimit = 5;
    boot.loader.timeout = 10;
    boot.loader.efi.canTouchEfiVariables = true;

    boot.lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
      autoGenerateKeys.enable = true;
      autoEnrollKeys.enable = true;
    };

    # Use latest kernel.
    boot.kernelPackages = pkgs.linuxPackages_latest;
  };
}
