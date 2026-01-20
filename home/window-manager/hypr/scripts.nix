{ pkgs, ... }:

{
  home.packages = [
    (pkgs.writeShellScriptBin "switchkb" ''
      #!/usr/bin/env bash

      # get the main keyboard device name
      kb=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .name')

      # switch to next layout
      hyprctl switchxkblayout "$kb" next

      # get the active layout name
      layout=$(hyprctl devices -j | jq -r '.keyboards[] | select(.name=="'"$kb"'") | .active_keymap')

      # notify via hyprpanel (fallback to notify-send if needed)
      hyprctl notify -1 1500 0 "Layout: $layout"
    '')

    (pkgs.writeShellScriptBin "hyprsunset-auto" ''
      #!/usr/bin/env bash
      TEMP=5000   # color temperature
      ON_START=23 # hour to enable
      ON_END=6    # hour to disable

      while true; do
        HOUR=$(date +%H)

        if ((HOUR >= ON_START || HOUR < ON_END)); then
          # Time is within night range → start if not running
          if ! pgrep -x hyprsunset >/dev/null; then
            hyprsunset -t "$TEMP" &
          fi
        else
          # Time is outside night range → stop if running
          pkill -x hyprsunset
        fi

        sleep 300 # check every 5 minutes
      done
    '')
  ];
}
