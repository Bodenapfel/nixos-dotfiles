{
  pkgs,
  config,
  lib,
  ...
}:

{
  options = {
    amdcpu.enable = lib.mkEnableOption "enables amdcpu";
  };

  config = lib.mkIf config.amdcpu.enable {
    hardware.cpu.amd.updateMicrocode = true;
    # powerManagement.cpuFreqGovernor = "performance";
  };
}
