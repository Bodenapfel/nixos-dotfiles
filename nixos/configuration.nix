{ ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # Custom modules
    ./modules/default.nix
  ];

  nixpkgs.config.allowUnfree = true;

  # Enable Flakes ad new nix cli tool
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      trusted-users = [
        "root"
        "dk"
      ];
      substituters = [ "https://claude-code.cachix.org" ];
      trusted-public-keys = [ "claude-code.cachix.org-1:YeXf2aNu7UTX8Vwrze0za1WEDS+4DuI2kVeWEE4fsRk=" ];
    };
    gc = {
      automatic = true;
      dates = [ "daily" ];
      options = "--delete-older-than 30d";
    };
  };

  # Don't change this unless you know what you're doin.
  # This only sets the first version of NixOS
  system.stateVersion = "25.11"; # Did you read the comment?
}
