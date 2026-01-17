{ config, lib, pkgs, ... }:
{
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    # Creates a persistent virtual sink named "soundboard"
    extraConfig.pipewire."91-soundboard-devices" = {
      "context.objects" = [
        # 1) Soundboard output sink (apps output here)
        {
          factory = "adapter";
          args = {
            "factory.name" = "support.null-audio-sink";
            "node.name" = "soundboard";
            "node.description" = "Soundboard";
            "media.class" = "Audio/Sink";
            "audio.position" = [ "FL" "FR" ];

            # optional: nicer UX in mixers
            "monitor.channel-volumes" = true;
            "monitor.passthrough" = true;
          };
        }

        # 2) “Loopback device” for Discord: a virtual microphone
        # (PipeWire creates a node you can pick as an Input Device in Discord)
        {
          factory = "adapter";
          args = {
            "factory.name" = "support.null-audio-sink";
            "node.name" = "soundboard_loopback";
            "node.description" = "Soundboard Loopback";
            "media.class" = "Audio/Source/Virtual";
            "audio.position" = [ "FL" "FR" ];
          };
        }
      ];
    };

    # 3) Route soundboard -> loopback mic
    extraConfig.pipewire."92-soundboard-to-loopback" = {
      "context.modules" = [
        {
          name = "libpipewire-module-loopback";
          args = {
            "node.description" = "Soundboard -> Loopback Mic";

            "capture.props" = {
              # capture from the *sink* named "soundboard"
              "stream.capture.sink" = true;
              "target.object" = "soundboard";
              "node.passive" = true;
            };

            "playback.props" = {
              # play into the virtual mic node
              "target.object" = "soundboard_loopback";
              "node.passive" = true;
            };
          };
        }
      ];
    };
  };
}
