{ config, lib, ... }:

let
  c = config.colorScheme.palette;
in
{
  options = { tmux.enable = lib.mkEnableOption "tmux configuration"; };

  config = lib.mkIf config.tmux.enable {
    programs.tmux = {
      enable = true;

      mouse = true;
      keyMode = "vi";
      prefix = "C-b";

      extraConfig = ''
        # Vim-like pane navigation (after prefix)
        bind h select-pane -L
        bind j select-pane -D
        bind k select-pane -U
        bind l select-pane -R

        # Your status + border colors
        # (modern equivalent of status-bg/status-fg)
        set -g status-style "bg=#${c.base0d},fg=#000000"

        set -g pane-border-style fg=#${c.base0c}
        set -g pane-active-border-style fg=#${c.base0d}
      '';
    };
  };
}
