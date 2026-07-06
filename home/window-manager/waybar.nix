{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  ...
}:

let
  c = config.colorScheme.palette;
  waybarLuaDispatchFix = pkgs-unstable.waybar.overrideAttrs (old: {
    version = "0.15.0";
    src = pkgs-unstable.fetchFromGitHub {
      owner = "Alexays";
      repo = "Waybar";
      rev = "97917db59369b66ef412a87f90cfdbda3ad55225";
      hash = "sha256-wqM3tVP4P6UWZzQo2Ufm3/Rja+fc8GbyraGZAFGlbDg=";
    };
    mesonFlags =
      builtins.filter (flag: flag != "-Dcava=enabled") (old.mesonFlags or [ ])
      ++ [ "-Dcava=disabled" ];
  });
in
{
  options = {
    waybar.enable = lib.mkEnableOption "Waybar status bar configuration";
  };

  config = lib.mkIf config.waybar.enable {
    systemd.user.services.playerctld = {
      Unit = {
        Description = "MPRIS playerctld";
        PartOf = [ "graphical-session.target" ];
      };

      Service = {
        ExecStart = "${pkgs.playerctl}/bin/playerctld";
        Restart = "on-failure";
      };
    };

    programs.waybar = {
      enable = true;
      package = waybarLuaDispatchFix;
      systemd.enable = false;

      settings = [
        {
          layer = "bottom";
          exclusive = "false";

          modules-left = [
            "hyprland/workspaces"
            "custom/mpris"
          ];
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
            format-connected = "<span foreground='#${c.base0c}'> </span>{num_connections}";
            tooltip-format = "{controller_alias}	{controller_address}";
            tooltip-format-connected = "{device_enumerate}";
            tooltip-format-enumerate-connected = "{device_alias} {device_battery_percentage}%";
          };

          "custom/mpris" = {
            exec = "${pkgs.writeShellScript "waybar-mpris" ''
              status="$(${pkgs.playerctl}/bin/playerctl -p playerctld status 2>/dev/null)" || exit 0
              [ "$status" = "Stopped" ] && exit 0

              title="$(${pkgs.playerctl}/bin/playerctl -p playerctld metadata title 2>/dev/null || true)"
              artist="$(${pkgs.playerctl}/bin/playerctl -p playerctld metadata artist 2>/dev/null || true)"
              album="$(${pkgs.playerctl}/bin/playerctl -p playerctld metadata album 2>/dev/null || true)"
              [ -z "$title$artist$album" ] && exit 0

              icon="<span foreground='#${c.base0c}'> </span>"
              [ "$status" = "Paused" ] && icon="<span foreground='#${c.base0c}'> </span>"

              text="$icon$title"
              tooltip="$title"
              [ -n "$artist" ] && tooltip="$tooltip - $artist"
              [ -n "$album" ] && tooltip="$tooltip - $album"

              ${pkgs.jq}/bin/jq -cn \
                --arg text "$text" \
                --arg tooltip "$tooltip" \
                --arg class "$(printf '%s' "$status" | tr '[:upper:]' '[:lower:]')" \
                '{text: $text, tooltip: $tooltip, class: $class}'
            ''}";
            return-type = "json";
            format = "{text}";
            hide-empty-text = true;
            max-length = 50;
            interval = 1;
            on-click = "${pkgs.playerctl}/bin/playerctl -p playerctld play-pause";
            on-click-middle = "${pkgs.playerctl}/bin/playerctl -p playerctld previous";
            on-click-right = "${pkgs.playerctl}/bin/playerctl -p playerctld next";
          };

          clock = {
            interval = 1;
            format = "<span color='#${c.base0c}'>󰃰 </span> {:%d.%m.%Y %H:%M:%S}";
            tooltip = true;
            tooltip-format = "{calendar}";
            on-click = "firefox";
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
            format-icons = {
              default = [
                " "
                " "
                "  "
              ];
            };
            on-click = "pavucontrol -t 3";
          };

          "custom/notification" = {
            tooltip = false;
            format = "{icon}";
            format-icons = {
              notification = "<span foreground='#${c.base0c}'>󰂚 </span><span foreground='red'><sup></sup></span>";
              none = "<span foreground='#${c.base0c}'>󰂚 </span>";
              dnd-notification = "<span foreground='#${c.base0c}'>󰂛 </span><span foreground='red'><sup></sup></span>";
              dnd-none = "<span foreground='#${c.base0c}'>󰂛 </span>";
              inhibited-notification = "<span foreground='#${c.base0c}'>󰂚 </span><span foreground='red'><sup></sup></span>";
              inhibited-none = "<span foreground='#${c.base0c}'>󰂛 </span>";
              dnd-inhibited-notification = "<span foreground='#${c.base0c}'>󰂚 </span><span foreground='red'><sup></sup></span>";
              dnd-inhibited-none = "<span foreground='#${c.base0c}'>󰂛 </span>";
            };
            return-type = "json";
            exec-if = "test -x swaync-client";
            exec = "swaync-client -swb";
            on-click = "swaync-client -t -sw";
            on-click-right = "swaync-client -d -sw";
            escape = true;
          };
        }
      ];

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
        #custom-mpris,
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
