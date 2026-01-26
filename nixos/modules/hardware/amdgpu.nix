{ pkgs, ... }:

{
  # enable overdrive for lact
  hardware.amdgpu.overdrive.enable = true;

  hardware.enableRedistributableFirmware = true;

  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      # rocm for btop
      rocmPackages.rocm-smi
      rocmPackages.rocminfo
    ];
  };

  systemd.packages = with pkgs; [ lact ];

  systemd.services.lactd.wantedBy = [ "multi-user.target" ];
}
