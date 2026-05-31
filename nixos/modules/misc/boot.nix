{
  pkgs,
  config,
  lib,
  ...
}:

{
  options = {
    boot.enable = lib.mkEnableOption "enable boot configuration";
  };

  config = lib.mkIf config.boot.enable {
    boot.loader.limine = {
      enable = true;
      maxGenerations = 5;
      secureBoot.enable = true;
      style.wallpapers = [ ];
      style.backdrop = "000000";
      # uid of the windows partition with vfat, thats small (like 100mb), look up detail on arch wiki or something
      extraEntries = ''
        /Microslop Windows
          protocol: efi
          path: guid(e04c8b1c-95b3-4b17-96a5-2cafd8075dd9):/EFI/Microsoft/Boot/bootmgfw.efi
      '';
    };
    boot.loader.timeout = 30;
    boot.loader.efi.canTouchEfiVariables = true;

    # boot.kernelPackages = pkgs.linuxPackages_zen;
  };
}
