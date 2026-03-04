{ pkgs, config, lib, ... }:

{
  home.activation.mimeapps = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ln -sf "${config.home.homeDirectory}/.dotfiles/home/misc/xdg/mimeapps.list" \
           "${config.home.homeDirectory}/.config/mimeapps.list"
  '';

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
