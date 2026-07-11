{
  config,
  pkgs,
  lib,
  ...
}:

{
  options = {
    portals.enable = lib.mkEnableOption "XDG portals and desktop entries";
  };

  config = lib.mkIf config.portals.enable {
    home.activation.mimeapps = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ln -sf "${config.home.homeDirectory}/.dotfiles/home/misc/xdg/mimeapps.list" \
             "${config.home.homeDirectory}/.config/mimeapps.list"
    '';

    home.activation.createUserDirs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p \
        "${config.home.homeDirectory}/Pictures/Screenshots" \
        "${config.home.homeDirectory}/Pictures/Wallpapers"
    '';

    xdg = {
      enable = true;

      userDirs = {
        enable = true;
        createDirectories = true;
        desktop = "${config.home.homeDirectory}/Desktop";
        download = "${config.home.homeDirectory}/Downloads";
        templates = "${config.home.homeDirectory}/Templates";
        publicShare = "${config.home.homeDirectory}/Public";
        documents = "${config.home.homeDirectory}/Documents";
        music = "${config.home.homeDirectory}/Music";
        pictures = "${config.home.homeDirectory}/Pictures";
        videos = "${config.home.homeDirectory}/Videos";
        setSessionVariables = false;
        extraConfig = {
          SCREENSHOTS = "${config.home.homeDirectory}/Pictures/Screenshots";
        };
      };

      portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-hyprland
          xdg-desktop-portal-gtk
        ];

        config.common = {
          default = [
            "hyprland"
            "gtk"
          ];
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
        exec = "firefox-nightly --new-window %f";
        type = "Application";
      };
    };
  };
}
