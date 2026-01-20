{ ... }:

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
      set -g status-style "bg=#5277C3,fg=#000000"

      set -g pane-border-style fg=#7EBAE4
      set -g pane-active-border-style fg=#5277C3
    '';
  };
}
