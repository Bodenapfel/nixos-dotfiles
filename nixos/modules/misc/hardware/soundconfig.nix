{ lib, config, ... }:

{
  options = { soundconfig.enable = lib.mkEnableOption "enables soundconfig"; };

  config = lib.mkIf config.soundconfig.enable {
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      extraConfig.pipewire."99-soundboard-sink" = {
        # Null sink — appears as "soundboard Output" in Vivaldi's audio settings
        # and in crosspipe. Connect its monitor port to Vesktop input in crosspipe.
        "context.objects" = [{
          factory = "adapter";
          args = {
            "factory.name" = "support.null-audio-sink";
            "node.name" = "soundboard_sink";
            "node.description" = "soundboard Output";
            "media.class" = "Audio/Sink";
            "audio.position" = "FL,FR";
            "node.pause-on-idle" = false;
          };
        }];

        # Loopback: soundboard_sink monitor → your real default output
        # so you hear audio normally while it also flows to Vesktop via crosspipe
        "context.modules" = [{
          name = "libpipewire-module-loopback";
          args = {
            "capture.props" = {
              "node.name" = "soundboard_loopback_in";
              "audio.position" = "FL,FR";
              "target.object" = "soundboard_sink";
              # Capture from the sink side (not its monitor)
              "stream.capture.sink" = true;
              "node.pause-on-idle" = false;
            };
            "playback.props" = {
              "node.name" = "soundboard_loopback_out";
              "audio.position" = "FL,FR";
              "node.pause-on-idle" = false;
              # Empty = follows your default output (speakers/headphones)
              "target.object" = "";
            };
          };
        }];
      };
    };
  };
}
