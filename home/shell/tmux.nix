{ config, pkgs, ... }:
{
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
      set -g status-style "bg=#99c1f2,fg=#000000"

      set -g pane-border-style fg=#99c1f2
      set -g pane-active-border-style fg=#48658b

      # Your old config had:
      #   unbind C-a
      #   bind C-b send-prefix
      #
      # With prefix = C-b, these are redundant because tmux already uses C-b
      # as prefix and "C-b C-b" sends the prefix through by default. :contentReference[oaicite:2]{index=2}
    '';
  };
}
