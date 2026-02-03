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
      "1password-cli"
      "1password"
      "bruno"
      "cursor"
      "daisydisk"
      "fantastical"
      "figma"
      "firefox"
      "font-fira-code-nerd-font"
      "font-fira-code"
      "font-fira-mono"
      "font-fira-sans"
      "font-hack-nerd-font"
      "font-ibm-plex"
      "font-jetbrains-mono"
      "font-monaspace"
      "font-permanent-marker"
      "font-space-mono"
      "ghostty"
      "home-assistant"
      "jordanbaird-ice"
      "keka"
      "macwhisper"
      "mitmproxy"
      "notion"
      "obsidian"
      "plexamp"
      "qflipper"
      "raycast"
      "readdle-spark"
      "shottr"
      "signal"
      "slack"
      "spotify"
      "syncthing-app"
      "tailscale-app"
      "vlc"
      "whatsapp"
    ];
  };
}
