{ config, pkgs, ... }:
{
  services.flatpak = {
    packages = [
      "com.github.tchx84.Flatseal"
      "io.github.Soundux"
      "org.torproject.torbrowser-launcher"
      "it.mijorus.gearlever"
      "org.inkscape.Inkscape"
    ];
    overrides = {
      global = {
        Context.sockets = [
          "wayland"
          "x11"
          "fallback-x11"
          "session-bus"
          "system-bus"
        ];
        Environment = {
          XCURSOR_PATH = "run/host/user-share/icons:/run/host/share/icons";
          GTK_THEME = "Graphite-Dark";
        };
        Filesystem.allow = [
          "home"
          "xdg-download"
        ];
        Context.devices = [
          "all"
        ];
      };
    };
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
  };
}
