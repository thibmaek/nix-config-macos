{ ... }:

###################################################################################
#
#  Homebrew configuration for macOS
#
#  Manages GUI applications and CLI tools that work better via Homebrew
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

    # CLI tools that work better via Homebrew
    brews = [
      # Add any Homebrew-only CLI tools here
      # Most CLI tools should be in home/packages.nix instead
      "ollama"
    ];

    # GUI macOS applications
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
      "logitech-options"
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
      "xcodes-app"
    ];
  };
}
