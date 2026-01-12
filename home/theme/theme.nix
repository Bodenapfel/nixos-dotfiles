# home/theme/theme.nix
{ config, pkgs, ... }:

{
  #### Cursor: Breeze Light
  home.pointerCursor = {
    package = pkgs.kdePackages.breeze;
    name = "Breeze_Light";
    size = 24;

    gtk.enable = true;
    x11.enable = true;
  };

  #### GTK: Graphite + Papirus icons
  gtk = {
    enable = true;

    theme = {
      package = pkgs.graphite-gtk-theme;
      # If this doesn't apply, check the exact directory name:
      #   nix build nixpkgs#graphite-gtk-theme && ls result/share/themes
      name = "Graphite-Dark";
    };

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      # Papirus provides Papirus, Papirus-Dark, Papirus-Light. :contentReference[oaicite:1]{index=1}
      name = "Papirus-Dark";
    };

    font = {
      name = "Comic Shans Mono";
      size = 11;
    };
  };

  #### Qt: qtct + Kvantum
  #
  # Note: HM often maps "qtct" -> the correct QT_QPA_PLATFORMTHEME ("qt5ct") internally,
  # depending on version. :contentReference[oaicite:2]{index=2}
  qt = {
    enable = true;
    platformTheme.name = "qtct";
  };

  #### Packages needed for Qt theming
  home.packages = with pkgs; [
    # Qt config tools
    libsForQt5.qt5ct
    kdePackages.qt6ct
    libsForQt5.qtstyleplugin-kvantum

    # Kvantum engine + manager
    kdePackages.qtstyleplugin-kvantum
  ]; # :contentReference[oaicite:3]{index=3}

  #### Rofi: match icon theme
  programs.rofi.extraConfig = {
    "icon-theme" = "Papirus-Dark";
  };

  #### Optional: force cursor env vars for stubborn apps
  # (Qt env vars are intentionally NOT set here to avoid conflicts with HM's qt module.)
  home.sessionVariables = {
    XCURSOR_THEME = "Breeze_Light";
    XCURSOR_SIZE = "24";
  };
}

