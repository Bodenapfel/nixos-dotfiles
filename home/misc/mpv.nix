{ pkgs, config, ... }:

{
  programs.mpv = {
    enable = true;

    config = {
      # Playback convenience
      save-position-on-quit = true;
      keep-open = true;
      resume-playback = true;
      autoload-files = true;
      loop-playlist = "no";

      # Performance
      hwdec = "auto-safe";
      vd-lavc-threads = 4;

      # Subtitles
      sub-auto = "fuzzy";
      sub-font-size = 48;
      sub-border-size = 2;
      sub-shadow-offset = 1;
      sub-color = "#FFFFFF";
      sub-border-color = "#000000";

      # Audio
      volume-max = 200;
      audio-device = "auto";

      # Video
      panscan = 1;

      # Color settings
      target-trc = "gamma2.2";
      target-colorspace-hint = "no";
    };
  };
}
