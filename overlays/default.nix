{ config, lib, pkgs, ... }: {
  # weird cmake bug
  nixpkgs.overlays = [
    (final: prev: {
      heroic-unwrapped = prev.heroic-unwrapped.override { electron_39 = prev.electron_38; };

      lager = prev.lager.overrideAttrs (old: {
        cmakeFlags = (old.cmakeFlags or [ ]) ++ [
          "-Dlager_BUILD_TESTS=OFF"
          "-Dlager_BUILD_FAILURE_TESTS=OFF"
          "-Dlager_BUILD_DOCS=OFF"
          "-Dlager_BUILD_DEBUGGER_EXAMPLES=OFF"
        ];
      });
    })
  ];
}
