{ pkgs, user, hostname, ... }:

{
  imports = [
    ./programs.nix
  ];

  home = {
    username = "${user}";
    homeDirectory = "/Users/${user}";
    stateVersion = "24.11";
    shellAliases = {
      nix-update-all-pkgs = "nix-channel --update && darwin-rebuild switch --flake ~/.config/nix/#${hostname}";
    };
    packages = pkgs.callPackage ./packages.nix {};
  };

  programs.home-manager.enable = true;
}
