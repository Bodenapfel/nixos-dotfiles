{ config, lib, ... }:

let
  c = config.colorScheme.palette;
in
{
  options = { waybar.enable = lib.mkEnableOption "Waybar status bar configuration"; };

  config = lib.mkIf config.waybar.enable {
    programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = [{
      layer = "top";

      modules-left = [ "hyprland/workspaces" "mpris" ];
      modules-center = [ "hyprland/window" ];
      modules-right = [
        "cpu"
        "memory"
        "bluetooth"
        "pulseaudio"
        "clock"
        "tray"
        "custom/notification"
      ];

      "hyprland/window" = {
        icon = true;
        format = "{class}";
      };

      "hyprland/workspaces" = {
        all-outputs = true;
        show-special = true;
        persistent-workspaces = {
          "1" = [ ];
          "2" = [ ];
          "3" = [ ];
          "4" = [ ];
          "5" = [ ];
        };
      };

      bluetooth = {
        on-click = "blueman-manager";
        format = "<span foreground='#${c.base0c}'> </span>on";
        format-disabled = "<span foreground='#${c.base0c}'> </span>off";
        format-connected =
          "<span foreground='#${c.base0c}'> </span>{num_connections}";
        tooltip-format = "{controller_alias}	{controller_address}";
        tooltip-format-connected = "{device_enumerate}";
        tooltip-format-enumerate-connected =
          "{device_alias} {device_battery_percentage}%";
      };

      mpris = {
        format = "{player_icon}{title}";
        format-paused = "{status_icon}{title}";
        player-icons = { default = "<span foreground='#${c.base0c}'> </span>"; };
        status-icons = { paused = "<span foreground='#${c.base0c}'> </span>"; };
        tooltip-format = "{dynamic}";
        max-length = 50;
      };

      clock = {
        interval = 1;
        format = "<span color='#${c.base0c}'>󰃰 </span> {:%d.%m.%Y %H:%M:%S}";
        tooltip = true;
        tooltip-format = "{calendar}";
        calendar = {
          mode = "month";
          weeks-pos = "right";
          format = {
            months = "<span color='#${c.base0d}'><b>{}</b></span>";
            days = "<span color='#${c.base05}'><b>{}</b></span>";
            weeks = "<span color='#${c.base0c}'><b>W{}</b></span>";
            weekdays = "<span color='#${c.base0c}'><b>{}</b></span>";
            today = "<span color='#${c.base0d}'><b><u>{}</u></b></span>";
          };
          actions = { };
        };
      };

      tray = {
        icon-size = 24;
        spacing = 10;
        icons = { };
      };

      cpu = {
        format = "<span color='#${c.base0c}'> </span> {usage}%";
        on-click = "kitty btop";
        tooltip = true;
      };

      memory = {
        format = "<span color='#${c.base0c}'> </span> {percentage}%";
        on-click = "kitty btop";
        tooltip = true;
      };

      pulseaudio = {
        format = "<span color='#${c.base0c}'>{icon}</span>{volume}%";
        format-muted = "<span color='#${c.base0c}'>  </span>{volume}%";
        format-icons = { default = [ " " " " "  " ]; };
        on-click = "pavucontrol -t 3";
      };

      "custom/notification" = {
        tooltip = false;
        format = "{icon}";
        format-icons = {
          notification =
            "<span foreground='#${c.base0c}'>󰂚 </span><span foreground='red'><sup></sup></span>";
          none = "<span foreground='#${c.base0c}'>󰂚 </span>";
          dnd-notification =
            "<span foreground='#${c.base0c}'>󰂛 </span><span foreground='red'><sup></sup></span>";
          dnd-none = "<span foreground='#${c.base0c}'>󰂛 </span>";
          inhibited-notification =
            "<span foreground='#${c.base0c}'>󰂚 </span><span foreground='red'><sup></sup></span>";
          inhibited-none = "<span foreground='#${c.base0c}'>󰂛 </span>";
          dnd-inhibited-notification =
            "<span foreground='#${c.base0c}'>󰂚 </span><span foreground='red'><sup></sup></span>";
          dnd-inhibited-none = "<span foreground='#${c.base0c}'>󰂛 </span>";
        };
        return-type = "json";
        exec-if = "test -x swaync-client";
        exec = "swaync-client -swb";
        on-click = "swaync-client -t -sw";
        on-click-right = "swaync-client -d -sw";
        escape = true;
      };
    }];

    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "ComicShannsMono Nerd Font", monospace;
        font-size: 20px;
        font-weight: bold;
        min-height: 2px;
      }

      @define-color bg #${c.base00};
      @define-color text #${c.base05};
      @define-color grey #${c.base04};
      @define-color blue #${c.base07};
      @define-color dark-blue #${c.base0f};
      @define-color green #${c.base0b};

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

      #memory,
      #bluetooth,
      #pulseaudio,
      #cpu,
      #mpris,
      #mode,
      #clock,
      #battery,
      #custom-notification {
        padding: 0 10px;
      }

      #mode {
        background: @bg;
        border-bottom: 3px solid @text;
      }

      #clock {
        background-color: @bg;
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
    };
  };
}
