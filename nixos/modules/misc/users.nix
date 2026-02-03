{ pkgs, config, lib, ... }:

{
  options = { users.enable = lib.mkEnableOption "enable users"; };

  config = lib.mkIf config.users.enable {
    users.users.dk = {
      shell = pkgs.zsh;
      isNormalUser = true;
      extraGroups = [ "wheel" "video" "i2c" "networkmanager" ];
      packages = with pkgs; [ tree ];
    };
  };
}
