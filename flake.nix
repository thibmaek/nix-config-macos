{
  description = "@thibmaek's Nix config for macOS";

  nixConfig.substituters = [ "https://cache.nixos.org" ];

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-25.05-darwin";
    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs dependencies.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      system = "aarch64-darwin";
      user = "thibmaek";

      # Helper function to create a Darwin system configuration
      mkDarwinSystem =
        hostDir:
        nix-darwin.lib.darwinSystem {
          inherit system;
          modules = [
            # Host-specific configuration (defines hostname)
            hostDir

            # Shared modules
            ./modules/nix-core.nix
            ./modules/pkgs.nix
            ./modules/programs.nix
            ./modules/system.nix
            ./modules/homebrew.nix

            # Host-specific modules (extend shared config)
            "${hostDir}/system.nix"
            "${hostDir}/homebrew.nix"

            # Home Manager
            home-manager.darwinModules.home-manager
            (
              { config, ... }:
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = inputs // {
                  inherit user;
                  hostname = config._module.args.hostname;
                  hostPackages = "${hostDir}/home-manager/packages.nix";
                  hostPrograms = "${hostDir}/home-manager/programs.nix";
                };
                home-manager.backupFileExtension = "bak";
                home-manager.users.${user} = import ./home;
              }
            )
          ];
        };
    in
    {
      # Machine configurations
      darwinConfigurations = {
        "Thib-Payflip" = mkDarwinSystem ./hosts/payflip;
        "Thibaults-Mac-Studio" = mkDarwinSystem ./hosts/mac-studio;
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."Thib-Payflip".pkgs;

      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-rfc-style;
    };
}
