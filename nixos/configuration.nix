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
  nix = {
    settings = { experimental-features = [ "nix-command" "flakes" ]; };
    optimise = {
      automatic = true;
      dates = [ "daily" ];
    };
    gc = {
      automatic = true;
      dates = [ "daily" ];
      options = "delete-older-than 30d";
    };
  };

  # Don't change this unless you know what you're doin.
  # This only sets the first version of NixOS
  system.stateVersion = "25.11"; # Did you read the comment?
}

