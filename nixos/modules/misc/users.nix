{ pkgs, ... }:

{
  users.users.dk = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "i2c" "networkmanager" ];
    packages = with pkgs; [ tree ];
  };
}
