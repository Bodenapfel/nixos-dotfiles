{ pkgs, config, lib, ... }:

{
  options = {
    virtualisation.enable = lib.mkEnableOption "enable virtualisation with virt-manager";
  };

  config = lib.mkIf config.virtualisation.enable {
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [ pkgs.OVMFFull.fd ];
        };
      };
    };

    virtualisation.spiceUSBRedirection.enable = true;

    programs.virt-manager.enable = true;

    users.users.dk.extraGroups = [ "libvirtd" ];
  };
}
