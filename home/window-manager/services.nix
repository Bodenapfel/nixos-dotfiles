{ config, lib, pkgs, ... }:

{
  options = {
    wmServices.enable = lib.mkEnableOption "window manager tray services";
  };

  config = lib.mkIf config.wmServices.enable {
    services.network-manager-applet.enable = true;
    services.blueman-applet.enable = true;
    services.kdeconnect.enable = true;
    services.kdeconnect.indicator = true;

    systemd.user.services.pause-reminder = {
      Unit.Description = "Pause reminder notification";

      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.libnotify}/bin/notify-send -u critical \"󰔛  Stretching-Pause\" \"50 Minuten vorbei. Kurz aufstehen, strecken und locker machen.\"";
      };
    };

    systemd.user.timers.pause-reminder = {
      Unit.Description = "Run pause reminder every 50 minutes";

      Timer = {
        OnBootSec = "50min";
        OnUnitActiveSec = "50min";
        Unit = "pause-reminder.service";
      };

      Install.WantedBy = [ "timers.target" ];
    };

    # blueman package now ships its own unit with ExecStart; the home-manager
    # drop-in adds a second ExecStart which systemd rejects. Clear it first.
    systemd.user.services.blueman-applet.serviceConfig.ExecStart = lib.mkForce [
      ""
      "${pkgs.blueman}/bin/blueman-applet"
    ];
  };
}
