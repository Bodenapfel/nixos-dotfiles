{ pkgs, config, ...}:
{
  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        # lock after 15 minutes
        {
          timeout = 900;
          on-timeout = "loginctl lock-session";
        }

        # screen off after 15.5 minutes
        {
          timeout = 930;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on && brightnessctl -r";
        }
      ];
    };
  };
}
