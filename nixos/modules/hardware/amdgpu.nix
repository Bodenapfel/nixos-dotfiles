{ config, pkgs, ... }:

{
  # enable overdrive for lact
  hardware.amdgpu.overdrive.enable = true;

  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  systemd.packages = with pkgs; [ lact ];

  systemd.services.lactd.wantedBy = [ "multi-user.target" ];

  # these options are from the lactd service definitio
}
