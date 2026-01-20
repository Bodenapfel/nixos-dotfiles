{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;

    # If you’re on Wayland you might be using rofi-wayland; keep if you know it works for you.
    # package = pkgs.rofi-wayland;

    theme =
      ./style.rasi; # programs.rofi.theme supports a path :contentReference[oaicite:1]{index=1}

    extraConfig = {
      # keys with hyphens must be quoted in Nix
      modi = "emoji,calc,window,drun,run";
      font = "ComicShannsMono Nerd Font 13";
      "show-icons" = true;
      "icon-theme" = "Papirus-Dark";

      "display-drun" = "APPS";
      "display-run" = "RUN";
      "display-window" = "WINDOW";

      "hover-select" = false;
      "scroll-method" = 1;

      "me-select-entry" = "";
      "me-accept-entry" = "MousePrimary";

      "drun-display-format" = "{name}";
      "window-format" = "{w} · {c} · {t}";
    };

    # Optional: install plugins that match your modi list
    plugins = with pkgs; [ rofi-calc rofi-emoji ];
  };
}
