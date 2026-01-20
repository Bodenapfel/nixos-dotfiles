{ config, pkgs, ... }:

{
  # ddcci setup
  hardware.i2c.enable = true;
  boot.extraModulePackages = [ config.boot.kernelPackages.ddcci-driver ];
  boot.kernelModules = [ "i2c-dev" "i2c-piix4" "ddcci_backlight" ];

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # AMD CPU microcode / firmware
  hardware.enableRedistributableFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;

  services.udev.packages = [ pkgs.openrgb pkgs.wooting-udev-rules ];
}
