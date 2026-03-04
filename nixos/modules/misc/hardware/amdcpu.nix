{ pkgs, config, lib, ... }:

{
  options = { amdcpu.enable = lib.mkEnableOption "enables amdcpu"; };

  config = lib.mkIf config.amdcpu.enable {
    # AMD CPU microcode / firmware
    hardware.cpu.amd.updateMicrocode = true;
  };
}
