{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:

{
  options = {
    gaming.enable = lib.mkEnableOption "gaming packages";
  };

  config = lib.mkIf config.gaming.enable {
    home.packages = with pkgs; [
      pkgs-unstable.prismlauncher
      beyond-all-reason
      heroic
      (pkgs-unstable.discord.override {
        withVencord = true;
        withOpenASAR = true;
      })
      teamspeak6-client
      pkgs-unstable.steamtinkerlaunch
    ];
  };
}
