{ config, pkgs, lib, ... }:

{
  options = { vscode.enable = lib.mkEnableOption "VSCode configuration"; };

  config = lib.mkIf config.vscode.enable {
    programs.vscode = {
      enable = true;
      profiles.default.extensions = with pkgs.vscode-extensions; [
        dracula-theme.theme-dracula
        vscodevim.vim
        yzhang.markdown-all-in-one
      ];
    };
  };
}
