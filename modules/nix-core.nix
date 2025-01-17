{ pkgs, lib, user, ... }:

{
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    # substituters that will be considered before the official ones(https://cache.nixos.org)
    # substituters = [ "https://nix-community.cachix.org" ];
    # trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
    # builders-use-substitutes = true;

    trusted-users = [ user ];
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  nix.gc = {
    automatic = lib.mkDefault true;
    options = lib.mkDefault "--delete-older-than 7d";
  };
}
