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
      #   "/home/dk/remote/media" = {
      #     device = "//192.168.105.118/Media";
      #     fsType = "cifs";
      #     options = [
      #       "credentials=/etc/nixos/smbcreds"
      #       "iocharset=utf8"
      #       "rw"
      #       "uid=1000"
      #       "gid=100"
      #       "vers=3"
      #       "x-systemd.automount"
      #       "x-systemd.idle-timeout=2min"
      #       "nofail"
      #       "_netdev"
      #     ];
      #   };
      #   "/home/dk/Nextcloud" = {
      #     device = "https://nc.korbanet.de/remote.php/dav/files/david";
      #     fsType = "davfs";
      #     options = [ "uid=1000" "gid=100" "nofail" "_netdev" ];
      #   };
      # };
      # systemd.tmpfiles.rules = [
      #   # comment
      #   "d /home/dk/Nextcloud        0755 dk users -"
      # ];
    };
  };
}
