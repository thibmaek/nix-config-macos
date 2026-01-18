{ pkgs, user, hostPackages, hostPrograms, ... }:

{
  imports = [
    # Shared programs across all machines
    ./programs.nix
    ./shell.nix
    # Host-specific programs (can extend or override shared config)
    hostPrograms
  ];

  home = {
    username = "${user}";
    homeDirectory = "/Users/${user}";
    stateVersion = "24.11";
    packages =
      # Shared packages across all machines
      (pkgs.callPackage ./packages.nix { })
      # Host-specific packages
      ++ (pkgs.callPackage hostPackages { });
    sessionPath = [
      "/Users/${user}/.npm-global/bin" # You will need to set this by running `npm config set prefix ~/.npm-global`
      "/Users/${user}/.local/bin"
    ];
  };

  programs.home-manager.enable = true;
}
