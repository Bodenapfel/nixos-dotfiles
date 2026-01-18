{ config, pkgs, ... }:

{
  #### Cursor: Breeze Light
  home.pointerCursor = {
    package = pkgs.kdePackages.breeze;
    name = "Breeze_Light";
    size = 24;

    gtk.enable = true;
    # x11.enable = true;
  };

  #### GTK: Graphite + Papirus icons
  gtk = {
    enable = true;

    theme = {
      package = pkgs.graphite-gtk-theme;
      name = "Graphite-Dark";
    };

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };

  };

  xdg.configFile."Kvantum/GraphiteDark/GraphiteDark.kvconfig".source = ./GraphiteDark/GraphiteDark.kvconfig;
  xdg.configFile."Kvantum/GraphiteDark/GraphiteDark.svg".source = ./GraphiteDark/GraphiteDark.svg;
  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=GraphiteDark
    '';

  qt = {
    enable = true;
    platformTheme.name = "qt5ct";
    style.name = "kvantum";
  };

  home.packages = with pkgs; [
    # Qt config tools
    libsForQt5.qt5ct
    kdePackages.qt6ct
    libsForQt5.qtstyleplugin-kvantum

    # Kvantum engine + manager
    kdePackages.qtstyleplugin-kvantum
    papirus-icon-theme
  ];

  home.sessionVariables = {
    XCURSOR_THEME = "Breeze_Light";
    XCURSOR_SIZE = "24";
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };
}
