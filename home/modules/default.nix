{ lib, ... }:

{
  imports = [
    ../shell/zsh.nix
    ../shell/tmux.nix
    ../shell/misc.nix
    ../shell/kitty.nix
    ../theme/theme.nix
    ../misc/mpv.nix
    ../misc/vivaldi.nix
    ../misc/vscode.nix
    ../misc/flatpak.nix
    ../misc/xdg/xdg.nix
    ../misc/programs.nix
    ../window-manager/rofi/rofi.nix
    ../window-manager/waybar.nix
    ../window-manager/swaync/swaync.nix
    ../window-manager/services.nix
    ../window-manager/hypr/scripts.nix
    ../window-manager/hypr/hypridle.nix
    ../window-manager/hypr/hyprlock.nix
    ../window-manager/hypr/wallpaper.nix
    ../window-manager/hypr/hyprland.nix
    ../gaming/mangohud.nix
    ../gaming/misc.nix
  ];

  zsh.enable = lib.mkDefault true;
  tmux.enable = lib.mkDefault true;
  kitty.enable = lib.mkDefault true;
  shell.enable = lib.mkDefault true;
  theme.enable = lib.mkDefault true;
  mpv.enable = lib.mkDefault true;
  vivaldi.enable = lib.mkDefault true;
  vscode.enable = lib.mkDefault true;
  flatpak.enable = lib.mkDefault true;
  portals.enable = lib.mkDefault true;
  apps.enable = lib.mkDefault true;
  rofi.enable = lib.mkDefault true;
  waybar.enable = lib.mkDefault true;
  swaync.enable = lib.mkDefault true;
  wmServices.enable = lib.mkDefault true;
  hyprScripts.enable = lib.mkDefault true;
  hypridle.enable = lib.mkDefault true;
  hyprlock.enable = lib.mkDefault true;
  wallpaper.enable = lib.mkDefault true;
  hyprland.enable = lib.mkDefault true;
  mangohud.enable = lib.mkDefault true;
  gaming.enable = lib.mkDefault true;
}
