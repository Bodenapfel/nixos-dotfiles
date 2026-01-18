{ pkgs, config, ...}:
{
  xdg.configFile."hypr/wallpapers/wallpaper.jpg".source = ./wallpapers/mojave.jpg;

  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      wallpaper = {
        monitor = "DP-3";
        path = "~/.config/hypr/wallpapers/wallpaper.jpg";
        fit_mode = "cover";
      };
    };
  };
}
