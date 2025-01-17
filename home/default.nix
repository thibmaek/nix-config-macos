{ user, hostname, ... }:

{
  imports = [
    ./core.nix
    ./programs.nix
  ];

  home = {
    username = "${user}";
    homeDirectory = "/Users/${user}";
    stateVersion = "24.11";
    shellAliases = {
      nix-update-all-pkgs = "nix-channel --update && darwin-rebuild switch --flake ~/.config/nix/#${hostname}";
    };
  };

  programs.home-manager.enable = true;
}
