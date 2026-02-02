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
  ];
}
