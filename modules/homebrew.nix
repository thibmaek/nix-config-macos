{ ... }:

###################################################################################
#
#  Shared Homebrew configuration across all machines
#
#  All the configuration options are documented here:
#    https://daiderd.com/nix-darwin/manual/index.html#opt-homebrew.enable
#
###################################################################################
{
  homebrew = {
    enable = true;

    onActivation = {
      # cleanup = "zap"; # Uninstall all packages not listed
      autoUpdate = true;
      upgrade = true;
    };

    # GUI macOS applications shared across all machines
    casks = [
      "1password"
      "cursor"
      "bruno"
      "slack"
      "daisydisk"
      "firefox"
      "fantastical"
      "figma"
      "font-monaspace"
      "ghostty"
      "keka"
      "macwhisper"
      "notion"
      "obsidian"
      "plexamp"
      "qflipper"
      "raycast"
      "readdle-spark"
      "shottr"
      "spotify"
      "syncthing-app"
      "tailscale-app"
      "whatsapp"
    ];
  };
}
