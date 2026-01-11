{ pkgs, options, ... }:
{
  programs.kitty = {
    enable = true;

    settings = {
      # Fonts
      font_family = "ComicShannsMono Nerd Font";
      font_size = 12.0;

      # Cursor
      cursor_stop_blinking_after = 0.0;
      cursor_trail = 1;

      # Window layout
      window_border_width = "0.0pt";
      draw_minimal_borders = true;
      window_margin_width = 0;
      window_padding_width = 0;
      single_window_padding_width = 2;
      hide_window_decorations = true;

      # Behavior
      confirm_os_window_close = 0;

      # Background / transparency
      background_opacity = "0.5";
      background_blur = 1;
      background_tint = "1.0";
    };

    extraConfig = ''
      include current-theme.conf
    '';
  };
}
