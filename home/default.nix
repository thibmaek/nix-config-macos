{ pkgs, user, ... }:

{
  imports = [
    ./programs.nix
    ./shell.nix
  ];

  home = {
    username = "${user}";
    homeDirectory = "/Users/${user}";
    stateVersion = "24.11";
    packages = pkgs.callPackage ./packages.nix { };
    sessionPath = [
      "/Users/${user}/.npm-global/bin" # You will need to set this by running `npm config set prefix ~/.npm-global`
      "/Users/${user}/.local/bin"
    ];
  };

  programs.home-manager.enable = true;
}
