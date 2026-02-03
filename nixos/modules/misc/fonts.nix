{ pkgs, config, lib, ... }:

{
  options = { fonts.enable = lib.mkEnableOption "enable custom fonts"; };

  config = lib.mkIf config.fonts.enable {
    fonts = {
      enableDefaultPackages = true;
      packages = with pkgs; [
        corefonts

        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji

        liberation_ttf
        inter
        roboto
        dejavu_fonts

        nerd-fonts.comic-shanns-mono
        nerd-fonts.fira-code
      ];
      fontDir.enable = true;
    };
  };
}
