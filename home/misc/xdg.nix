{ pkgs, ... }:

{
  xdg = {
    enable = true;

    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
      ];

      config.common = {
        default = [ "hyprland" "gtk" ];
        "org.freedesktop.impl.portal.OpenURI" = [ "gtk" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
      };
    };

    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/plain" = "kitty-nvim.desktop";
        "text/x-python" = "kitty-nvim.desktop";
        "text/x-shellscript" = "kitty-nvim.desktop";
        "text/x-c" = "kitty-nvim.desktop";
        "text/x-c++" = "kitty-nvim.desktop";
        "text/x-java" = "kitty-nvim.desktop";
        "text/x-markdown" = "kitty-nvim.desktop";
        "text/css" = "kitty-nvim.desktop";
        "text/html" = "kitty-nvim.desktop";
        "application/json" = "kitty-nvim.desktop";
        "application/xml" = "kitty-nvim.desktop";
        "application/x-yaml" = "kitty-nvim.desktop";
        "application/pdf" = "vivaldi.desktop";
        "x-scheme-handler/discord" = "vesktop.desktop";
        "inode/directory" = "thunar.desktop";
        "x-scheme-handler/http" = "vivaldi.desktop";
        "x-scheme-handler/https" = "vivaldi.desktop";
        "x-scheme-handler/about" = "vivaldi.desktop";
        "x-scheme-handler/unknown" = "vivaldi.desktop";
      };
    };

    desktopEntries.kitty-nvim = {
      name = "Neovim (Kitty)";
      exec = "kitty nvim %f";
      type = "Application";
      noDisplay = true;
    };
    desktopEntries.firefox-pdf = {
      name = "Firefox (PDF Window)";
      exec = "firefox --new-window %f";
      type = "Application";
    };
  };
}
