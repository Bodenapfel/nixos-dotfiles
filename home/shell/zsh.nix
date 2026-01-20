{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "tmux" "rust" "extract" "colored-man-pages" ];
      theme = "";
    };
    plugins = [{
      name = "vi-mode";
      src = pkgs.zsh-vi-mode;
      file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
    }];
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
      hypr = "start-hyprland";
      windows = "sudo efibootmgr --bootnext 0000 && reboot";
      clfetch = "clear && fastfetch";
      server = "ssh dk@192.168.105.118";
      ubumount = "sshfs root@192.168.105.118:/ ~/remote/root@ubuntu";
      dkmount = "sshfs dk@192.168.105.118:/home/dk/ ~/remote/dk@ubuntu";
      media = "sshfs dk@192.168.105.118:/data/ ~/remote/media";
      cpfonts =
        "sudo rm -rf $HOME/.local/share/fonts; mkdir $HOME/.local/share/fonts && cp -L /run/current-system/sw/share/X11/fonts/* $HOME/.local/share/fonts/";
    };
    history.size = 10000;
    initContent = lib.mkOrder 1500 ''
      # yazi wrapper: lets yazi write the chosen cwd to a temp file, then `cd` there
      y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        yazi "$@" --cwd-file="$tmp"
        IFS= read -r cwd < "$tmp"
        [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
        rm -f -- "$tmp"
      }

      PROMPT='%F{blue}%B%n@%m %~
      >>%f%b '

      if [[ -z $NO_COWSAY ]]; then
        cowthink -f tux "$(fortune -s)"
      fi
    '';
  };
}
