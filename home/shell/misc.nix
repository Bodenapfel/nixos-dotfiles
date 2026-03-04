{ config, lib, ... }:

let
  c = config.colorScheme.palette;
in
{
  options = { shell.enable = lib.mkEnableOption "shell utilities (btop, fastfetch)"; };

  config = lib.mkIf config.shell.enable {
    programs.btop = {
      enable = true;
      settings = { vim_keys = true; };
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
            "1" = "#${c.base0c}";
            "2" = "#${c.base0d}";
            "3" = "#${c.base0c}";
            "4" = "#${c.base0d}";
            "5" = "#${c.base0c}";
            "6" = "#${c.base0d}";
          };
        };
        display = {
          separator = ": ";
          color = {
            keys = "#${c.base0c}";
            title = "#${c.base0d}";
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
  };
}
