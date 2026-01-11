{ config, pkgs, lib, ... }:

let
  kitty = lib.getExe pkgs.kitty;
  btop = lib.getExe pkgs.btop;
  pavucontrol = lib.getExe pkgs.pavucontrol;

  bluemanManager = "${pkgs.blueman}/bin/blueman-manager";
  swayncClient = "${pkgs.swaynotificationcenter}/bin/swaync-client";
in
{
  programs.waybar = {
    enable = true;

    # Autostart Waybar via systemd user service (recommended).
    # Options documented here: :contentReference[oaicite:0]{index=0}
    systemd.enable = true;

    # If Hyprland modules show as "unknown module", use an experimental build:
    # (This overlay-style fix is commonly used for missing workspace modules.) :contentReference[oaicite:1]{index=1}
    # package = pkgs.waybar.overrideAttrs (old: {
    #   mesonFlags = (old.mesonFlags or [ ]) ++ [ "-Dexperimental=true" ];
    # });
  };

  # Your Waybar config (kept as JSONC, but written to the default filename "config").
  xdg.configFile."waybar/config".text = ''
    {
      "layer": "top",
      "modules-left": [
        "hyprland/workspaces",
        "mpris"
      ],
      "modules-center": [
        "hyprland/window"
      ],
      "modules-right": [
        "cpu",
        "memory",
        "bluetooth",
        "pulseaudio",
        "clock",
        "tray",
        "custom/notification"
      ],
      "hyprland/window": {
        "icon": true,
        "format": "{class}"
      },
      "hyprland/workspaces": {
        "all-outputs": true,
        "show-special": true,
        "persistent-workspaces": {
          "1": [],
          "2": [],
          "3": [],
          "4": [],
          "5": []
        }
      },
      "bluetooth": {
        // "controller": "controller1",
        "on-click": "${bluemanManager}",
        "format": "<span foreground=\\"#99C1F1\\"> </span>on",
        "format-disabled": "<span foreground=\\"#99C1F1\\"> </span>off",
        "format-connected": "<span foreground=\\"#99C1F1\\"> </span>{num_connections}",
        "tooltip-format": "{controller_alias}\\t{controller_address}",
        "tooltip-format-connected": "{device_enumerate}",
        "tooltip-format-enumerate-connected": "{device_alias} {device_battery_percentage}%"
      },
      "mpris": {
        "format": "{player_icon}{title}",
        "format-paused": "{status_icon}{title}",
        "player-icons": {
          "default": "<span foreground=\\"#99C1F1\\"> </span>"
        },
        "status-icons": {
          "paused": "<span foreground=\\"#99C1F1\\"> </span>"
        },
        "tooltip-format": "{dynamic}",
        "max-length": 50
      },
      "clock": {
        "interval": 1,
        "format": "<span color=\\"#99C1F1\\">󰃰 </span> {:%d.%m.%Y %H:%M:%S}",
        "tooltip": true,
        "tooltip-format": "{calendar}",
        "calendar": {
          "mode": "month",
          "weeks-pos": "right",
          "format": {
            "months": "<span color='#739ade'><b>{}</b></span>",
            "days": "<span color='#ffffff'><b>{}</b></span>",
            "weeks": "<span color='#99C1F1'><b>W{}</b></span>",
            "weekdays": "<span color='#99C1F1'><b>{}</b></span>",
            "today": "<span color='#739ade'><b><u>{}</u></b></span>"
          },
          "actions": {}
        }
      },
      "tray": {
        "icon-size": 24,
        "spacing": 10,
        "icons": {
          // "steam": "steam",
          // "vesktop": "discord"
        }
      },
      "cpu": {
        "format": "<span color=\\"#99C1F1\\"> </span> {usage}%",
        "on-click": "${kitty} ${btop}",
        "tooltip": true
      },
      "memory": {
        "format": "<span color=\\"#99C1F1\\"> </span> {percentage}%",
        "on-click": "${kitty} ${btop}",
        "tooltip": true
      },
      "pulseaudio": {
        "format": "<span color=\\"#99C1F1\\">{icon}</span>{volume}%",
        "format-muted": "<span color=\\"#99C1F1\\">  </span>{volume}%",
        "format-icons": {
          "default": [
            " ",
            " ",
            "  "
          ]
        },
        "on-click": "${pavucontrol} -t 3"
      },
      "custom/notification": {
        "tooltip": false,
        "format": "{icon}",
        "format-icons": {
          "notification": "<span foreground=\\"#99C1F1\\">󰂚 </span><span foreground='red'><sup></sup></span>",
          "none": "<span foreground=\\"#99C1F1\\">󰂚 </span>",
          "dnd-notification": "<span foreground=\\"#99C1F1\\">󰂛 </span><span foreground='red'><sup></sup></span>",
          "dnd-none": "<span foreground=\\"#99C1F1\\">󰂛 </span>",
          "inhibited-notification": "<span foreground=\\"#99C1F1\\">󰂚 </span><span foreground='red'><sup></sup></span>",
          "inhibited-none": "<span foreground=\\"#99C1F1\\">󰂛 </span>",
          "dnd-inhibited-notification": "<span foreground=\\"#99C1F1\\">󰂚 </span><span foreground='red'><sup></sup></span>",
          "dnd-inhibited-none": "<span foreground=\\"#99C1F1\\">󰂛 </span>"
        },
        "return-type": "json",
        "exec-if": "test -x ${swayncClient}",
        "exec": "${swayncClient} -swb",
        "on-click": "${swayncClient} -t -sw",
        "on-click-right": "${swayncClient} -d -sw",
        "escape": true
      }
    }
  '';

  xdg.configFile."waybar/style.css".text = ''
    * {
      border: none;
      border-radius: 0;
      font-family: "ComicShannsMono Nerd Font", monospace;
      font-size: 20px;
      font-weight: bold;
      min-height: 2px;
    }

    @define-color bg rgba(32, 37, 53, 1.0);
    @define-color text rgba(255, 255, 255, 1.0);
    @define-color grey rgba(150, 150, 150, 1.0);
    @define-color blue rgba(153, 193, 242, 1.0);
    @define-color dark-blue rgba(113, 153, 222, 1.0);
    @define-color green rgba(80, 135, 80, 1.0);

    window#waybar {
      background: @bg;
      color: @text;
    }

    tooltip {
      background: @bg;
      border: 3px solid rgba(100, 114, 125, 0.5);
      border-radius: 5px;
    }

    tooltip label {
      color: @text;
    }

    #tray {
      padding: 0 10px;
    }

    #tray menu {
      background: @bg;
      border: 3px solid rgba(100, 114, 125, 0.5);
      border-radius: 5px;
    }

    #workspaces {
      padding: 0 10px;
      font-size: 24px;
    }

    #workspaces label {
      font-size: 24px;
    }

    #workspaces button {
      padding: 1px;
      font-size: 20px;
      background: transparent;
      color: @dark-blue;
      padding: 0 4px;
      margin: 5px 4px;

    }

    #workspaces button.empty {
      color: @grey;
    }

    #workspaces button.visible {
      color: @bg;
      background: @blue;
      border-radius: 5px;
    }

    #workspaces button:hover {
      color: @bg;
      background: @dark-blue;
      border-radius: 5px;
    }

    #memory {
      padding: 0 10px;
    }

    #bluetooth {
      padding: 0 10px;
    }

    #pulseaudio {
      padding: 0 10px;
    }

    #cpu {
      padding: 0 10px;
    }

    #mpris {
      padding: 0 10px;
    }

    #mode,
    #clock,
    #battery {
      padding: 0 10px;
    }

    #mode {
      background: @bg;
      border-bottom: 3px solid @text;
    }

    #clock {
      background-color: @bg;
    }

    #custom-notification {
      padding: 0 10px;
    }

    @keyframes blink {
      to {
        background-color: @bg;
        color: black;
      }
    }

    #battery.warning:not(.charging) {
      background: @bg;
      color: @text;
      animation-name: blink;
      animation-duration: 0.5s;
      animation-timing-function: steps(12);
      animation-iteration-count: infinite;
      animation-direction: alternate;
    }
  '';

  # Components referenced by your config (click actions + notification daemon)
  home.packages = with pkgs; [
    swaynotificationcenter
  ];

  # Provide swaync + swaync-client (your Waybar module calls swaync-client). :contentReference[oaicite:2]{index=2}
  services.swaync.enable = true;
}
