{ pkgs, config, lib, ... }:

{
  options = { boot.enable = lib.mkEnableOption "enable boot configuration"; };

  config = lib.mkIf config.boot.enable {
    boot.loader.limine = {
      enable = true;
      maxGenerations = 5;
      secureBoot.enable = true; # enable after enrolling keys in BIOS
    };
    boot.loader.timeout = 10;
    boot.loader.efi.canTouchEfiVariables = true;

    # Use latest kernel.
    boot.kernelPackages = pkgs.linuxPackages_latest;
  };
}
