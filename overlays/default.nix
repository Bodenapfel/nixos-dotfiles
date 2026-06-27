{ claude-code, codex-cli }:
{
  config,
  lib,
  pkgs,
  ...
}:
{
  nixpkgs.overlays = [
    claude-code.overlays.default
    codex-cli.overlays.default
    # (final: prev: {
    #
    #   weird cmake bug
    #   lager = prev.lager.overrideAttrs (old: {
    #     cmakeFlags = (old.cmakeFlags or [ ]) ++ [
    #       "-Dlager_BUILD_TESTS=OFF"
    #       "-Dlager_BUILD_FAILURE_TESTS=OFF"
    #       "-Dlager_BUILD_DOCS=OFF"
    #       "-Dlager_BUILD_DEBUGGER_EXAMPLES=OFF"
    #     ];
    #   });
    # })
  ];
}
