{ lib, ... }:

{
  imports = [
    ./misc/boot.nix
    ./misc/filesystems.nix
    ./misc/fonts.nix
    ./misc/hardware.nix
    ./misc/locale.nix
    ./misc/network.nix
    ./misc/programs.nix
    ./misc/services.nix
    ./misc/users.nix
    ./misc/virtualisation.nix
  ];

  boot.enable = lib.mkDefault true;
  filesystems.enable = lib.mkDefault true;
  fonts.enable = lib.mkDefault true;
  locale.enable = lib.mkDefault true;
  network.enable = lib.mkDefault true;
  programs.enable = lib.mkDefault true;
  services.enable = lib.mkDefault true;
  users.enable = lib.mkDefault true;
  virtualisation.enable = lib.mkDefault true;
}
