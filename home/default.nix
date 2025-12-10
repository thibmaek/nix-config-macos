{ pkgs, user, ... }:

{
  imports = [
    ./programs.nix
  ];

  home = {
    username = "${user}";
    homeDirectory = "/Users/${user}";
    stateVersion = "24.11";
    shellAliases = {
      nix-update-all-pkgs = "nix-channel --update && darwin-rebuild switch --flake ~/.config/nix";
      dl = "cd ~/Downloads";
      d = "cd ~/Desktop";
      n = "nvim";
    };
    packages = pkgs.callPackage ./packages.nix { };
    sessionPath = [
      "/Users/${user}/.npm-global/bin" # You will need to set this by running `npm config set prefix ~/.npm-global`
      "/Users/${user}/.local/bin"
    ];
  };

  programs.home-manager.enable = true;
}
