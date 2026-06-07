{
  description = "NixOS configuration";

  inputs = {
    # stable nixpkgs channel (default)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    # unstable nixpkgs for packages that need it
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    nix-colors.url = "github:misterio77/nix-colors";
    claude-code.url = "github:sadjow/claude-code-nix";
    codex-cli.url = "github:sadjow/codex-cli-nix";
  };

  outputs =
    inputs@{
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      nix-flatpak,
      nix-colors,
      claude-code,
      codex-cli,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs-unstable = import nixpkgs-unstable {
        system = system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        nixbtw = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit pkgs-unstable; };
          modules = [
            ./nixos/configuration.nix
            nix-flatpak.nixosModules.nix-flatpak
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit pkgs-unstable; };
                users = {
                  dk = {
                    imports = [
                      ./home/home.nix
                      nix-flatpak.homeManagerModules.nix-flatpak
                      nix-colors.homeManagerModules.default
                    ];
                  };
                };
                backupFileExtension = "backup";
              };

              # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
            }

            # overlays

            (import ./overlays/default.nix { inherit claude-code codex-cli; })
          ];
        };
      };
    };
}
