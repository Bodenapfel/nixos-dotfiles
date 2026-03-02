{ pkgs, ... }:

{
  programs.vivaldi = {
    enable = true;
    package = pkgs.vivaldi;
  };
  home.file.".config/vivaldi/usercss/custom.css" = {
    text = ''
      /* removed shadow from tab icons in dark themes */
      .theme-dark .favicon:not(.svg) {
           filter: none !important;
      } 
      /* removed the blurry text in the tab bar */
      .tab-position {
          will-change: auto !important;
      }
    '';
  };
}
