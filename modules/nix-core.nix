{
  pkgs,
  user,
  ...
}:

{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    # substituters that will be considered before the official ones(https://cache.nixos.org)
    # substituters = [ "https://nix-community.cachix.org" ];
    # trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
    # builders-use-substitutes = true;

    trusted-users = [ user ];
  };

  # Nix daemon is managed by Determinate Nix; we do not enable nix-darwin's Nix service.
  nix.enable = false;
  nix.package = pkgs.nix;
}
