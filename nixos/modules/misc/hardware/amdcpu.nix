{ pkgs, config, lib, ... }:

{
  options = { amdcpu.enable = lib.mkEnableOption "enables amdcpu"; };

  config = lib.mkIf config.amdcpu.enable {
    # AMD CPU microcode / firmware
    hardware.enableRedistributableFirmware = true;
    hardware.cpu.amd.updateMicrocode = true;

    services.udev.packages = [ pkgs.openrgb pkgs.wooting-udev-rules ];
  };
}
