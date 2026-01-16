{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;

    # Imports env vars into systemd user session and provides hyprland-session.target
    # (default is true, keeping it explicit is fine)
    systemd.enable = true; # :contentReference[oaicite:5]{index=5}

    # Keep your config in Hyprland syntax (minimal migration pain)
    extraConfig = builtins.readFile ./hypr/hyprland.conf; # :contentReference[oaicite:6]{index=6}
  };

  #### Services you currently start via exec-once (make them declarative)
  services.network-manager-applet.enable = true; # :contentReference[oaicite:9]{index=9}
  services.blueman-applet.enable = true;         # requires NixOS services.blueman.enable :contentReference[oaicite:10]{index=10}
  services.kdeconnect.enable = true;
  services.kdeconnect.indicator = true;          # :contentReference[oaicite:11]{index=11}

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

  xdg.configFile."hypr/wallpapers/wallpaper.jpg".source = ./wallpapers/mojave.jpg;

  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      wallpaper = {
        monitor = "DP-3";
        path = "~/.config/hypr/wallpapers/wallpaper.jpg";
        fit_mode = "cover";
      };
    };
  };

  programs.hyprlock = {
    enable = true;

    settings = {
      background = {
        monitor = "";
        path = "~/.config/hypr/wallpapers/wallpaper.jpg";
      };

      input-field = {
        monitor = "";
        size = "200, 50";
        outline_thickness = 3;

        dots_size = 0.33;
        dots_spacing = 0.15;
        dots_center = true;
        dots_rounding = -1;

        outer_color = "rgb(15,15,15)";
        inner_color = "rgb(255,255,255)";
        font_color  = "rgb(10,10,10)";

        fade_on_empty = true;
        fade_timeout = 1000;

        placeholder_text = "<i>Input Password...</i>";
        hide_input = false;

        rounding = -1;

        check_color = "rgb(204,136,34)";
        fail_color  = "rgb(204,34,34)";
        fail_text   = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
        fail_transition = 300;

        capslock_color = -1;
        numlock_color  = -1;
        bothlock_color = -1;
        invert_numlock = false;
        swap_font_color = false;

        position = "0, -20";
        halign = "center";
        valign = "center";
      };

      label = [
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$TIME\"";
          color = "rgba(200,200,200,1.0)";
          font_size = 55;
          font_family = "Fira Semibold";
          position = "-100, 40";
          halign = "right";
          valign = "bottom";
          shadow_passes = 5;
          shadow_size = 10;
        }

        {
          monitor = "";
          text = "$USER";
          color = "rgba(200,200,200,1.0)";
          font_size = 20;
          font_family = "Fira Semibold";
          position = "-100, 160";
          halign = "right";
          valign = "bottom";
          shadow_passes = 5;
          shadow_size = 10;
        }
      ];
    };
  };
}


