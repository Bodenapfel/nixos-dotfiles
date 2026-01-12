{ config, pkgs, ... }:
{
  programs.btop = {
    enable = true;
    settings = {
      vim_keys = true;
    };
  };


  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "auto";
        width = 20;
        padding = {
          top = 0;
          left = 0;
          right = 2;
        };
        color = {
          "1" = "#9999ff";
          "2" = "#99C1F1";
        };
      };
      display = {
        separator = ": ";
        color = {
          keys = "#99C1F1";
          title = "#9999ff";
        };
        bar = {
          width = 10;
          char = {
            elapsed = "■";
            total = "-";
          };
        };
        percent = {
          type = 9;
          color = {
            green = "green";
            yellow = "light_yellow";
            red = "light_red";
          };
        };
      };
      modules = [
        "break"
        "title"
        "os"
        "host"
        "kernel"
        "uptime"
        "packages"
        "shell"
        "display"
        "de"
        "wm"
        "font"
        "terminal"
        "terminalfont"
        "cpu"
        "gpu"
        "memory"
        "swap"
        "localip"
      ];
    };
  };
}
