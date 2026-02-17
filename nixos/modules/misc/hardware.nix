{ lib, ... }:

{
  imports = [
    ./hardware/amdgpu.nix
    ./hardware/amdcpu.nix
    ./hardware/misc.nix
    ./hardware/printing.nix
    ./hardware/soundconfig.nix
    ./hardware/virtual.nix
  ];

  amdgpu.enable = lib.mkDefault true;
  amdcpu.enable = lib.mkDefault true;
  misc.enable = lib.mkDefault true;
  printing.enable = lib.mkDefault true;
  soundconfig.enable = lib.mkDefault true;
  virtual.enable = lib.mkDefault true;
}
