{ config, lib, ... }:

{
  options = { misc.enable = lib.mkEnableOption "enables misc"; };

  config = lib.mkIf config.misc.enable {
    # ddcci setup
    hardware.i2c.enable = true;
    boot.extraModulePackages = [ config.boot.kernelPackages.ddcci-driver ];
    boot.kernelModules = [ "i2c-dev" "i2c-piix4" "ddcci_backlight" ];

    # Bluetooth
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;
  };
}
