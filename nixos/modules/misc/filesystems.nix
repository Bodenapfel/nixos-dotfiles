{ config, lib, ... }:

{
  options = {
    filesystems.enable = lib.mkEnableOption "enable custom filesystem mounts";
  };

  config = lib.mkIf config.filesystems.enable {
    fileSystems = {
      "/home/dk/mnt" = {
        device = "UUID=8162f18d-4bde-4348-a2a3-a3ea0a372dd3";
        fsType = "ext4";
        options = [ "nofail" ];
      };
    };
  };
}
