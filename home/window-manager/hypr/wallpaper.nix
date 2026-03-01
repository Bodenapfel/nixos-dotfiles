{ pkgs, ... }:

{
  xdg.configFile."hypr/wallpapers/wallpaper.jpg".source =
    ./wallpapers/mojave.jpg;

  # services.hyprpaper = {
  #   enable = true;
  #   package = pkgs-unstable.hyprpaper;
  #   settings = {
  #     splash = false;
  #     wallpaper = [{
  #       monitor = "DP-3";
  #       path = "~/.config/hypr/wallpapers/wallpaper.jpg";
  #       fit_mode = "cover";
  #     }];
  #   };
  # };
  services.swww = {
    enable = true;
    package = pkgs.swww;
  };
}
