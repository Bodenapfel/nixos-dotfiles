{ config, pkgs, ... }:

{
  users.users.dk = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups =
      [ "wheel" "video" "i2c" "networkmanager" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [ tree ];
  };
}
