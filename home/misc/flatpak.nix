{ ... }:

{
  services.flatpak = {
    packages = [
      "com.github.tchx84.Flatseal"
      "io.github.Soundux"
      "org.torproject.torbrowser-launcher"
      "it.mijorus.gearlever"
      "org.inkscape.Inkscape"
      "org.kde.kdenlive"
      "io.gitlab.adhami3310.Footage"
      "org.xonotic.Xonotic"
      "org.upscayl.Upscayl"
      "tv.kodi.Kodi"
    ];

    overrides = {
      global = {
        Environment = {
          XCURSOR_PATH = "run/host/user-share/icons:/run/host/share/icons";
          GTK_THEME = "Graphite-Dark";
        };
        Filesystem.allow = [ "home" "xdg-download" ];
        Context.devices = [ "all" ];
      };
    };
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
  };
}
