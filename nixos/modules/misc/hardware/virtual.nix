{ pkgs, config, lib, ... }:

{
  options = { virtual.enable = lib.mkEnableOption "enables virtualisation"; };

  config = lib.mkIf config.virtual.enable {
    virtualisation = {
      # virtualisation
      libvirtd = {
        # libvirtd
        enable = true;
      };
    };
  };
}
