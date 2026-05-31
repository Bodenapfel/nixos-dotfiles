{ config, lib, ... }:

{
  options = {
    hyprland.enable = lib.mkEnableOption "Hyprland config symlink";
  };

  config = lib.mkIf config.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      configType = "lua";
      extraConfig = builtins.readFile ./hyprland.lua;
    };

    home.activation.hyprlandConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p "${config.home.homeDirectory}/.config/hypr"
      ln -sfnT "${config.home.homeDirectory}/.dotfiles/home/window-manager/hypr/hyprland" \
               "${config.home.homeDirectory}/.config/hypr/hyprland"
    '';
  };
}
