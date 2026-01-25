{ pkgs, ... }:

{
  home.username = "dk";
  home.homeDirectory = "/home/dk";

  imports = [
    ./shell/zsh.nix
    ./shell/tmux.nix
    ./shell/misc.nix
    ./shell/kitty.nix
    ./theme/theme.nix
    ./misc/mpv.nix
    ./misc/vscode.nix
    ./misc/flatpak.nix
    ./misc/xdg.nix
    ./misc/programs.nix
    ./window-manager/rofi/rofi.nix
    ./window-manager/waybar.nix
    ./window-manager/swaync/swaync.nix
    ./window-manager/services.nix
    ./window-manager/hypr/scripts.nix
    ./window-manager/hypr/hypridle.nix
    ./window-manager/hypr/hyprlock.nix
    ./window-manager/hypr/hyprpaper.nix
    ./window-manager/hypr/hyprland.nix
    ./gaming/mangohud.nix
    ./gaming/misc.nix
  ];

  home.sessionVariables = {
    BROWSER = "firefox";
    EDITOR = "nvim";
    TERMINAL = "kitty";
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.11";
}
