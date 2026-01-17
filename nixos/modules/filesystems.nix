{ config, pkgs, ... }:
{
  fileSystems = {
    "/home/dk/mnt" = {
      device = "UUID=8162f18d-4bde-4348-a2a3-a3ea0a372dd3";
      fsType = "ext4";
      options = [ "nofail" ]; 
    };
  };
}
