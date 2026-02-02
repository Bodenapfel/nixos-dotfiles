{
  description = "NixOS configuration";

  inputs = {
    # newest nixpkgs unstable channel
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # stable nixpkgs channel
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager/master";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # lanzaboote
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
  };

  outputs = inputs@{ nixpkgs, home-manager, lanzaboote, nix-flatpak
    , nixpkgs-stable, ... }:
    let
      system = "x86_64-linux";
      pkgs-stable = import nixpkgs-stable {
        system = system;
        config.allowUnfree = true;
      };
    in {
      nixosConfigurations = {
        nixbtw = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit pkgs-stable; };
          modules = [
            ./nixos/configuration.nix
            ./nixos/modules/default.nix
            nix-flatpak.nixosModules.nix-flatpak
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit pkgs-stable; };

              home-manager.users.dk = {
                imports = [
                  ./home/home.nix
                  nix-flatpak.homeManagerModules.nix-flatpak
                ];
              };

              # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
            }

            lanzaboote.nixosModules.lanzaboote
          ];
        };
      };
    };
}
