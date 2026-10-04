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

    brews = [
      "anomalyco/tap/opencode-v2"
      "yt-dlp"
    ];

    # GUI macOS applications shared across all machines
    casks = [
      "1password-cli"
      "1password"
      "bruno"
      "daisydisk"
      "fantastical"
      "figma"
      "font-fira-code-nerd-font"
      "font-fira-code"
      "font-fira-mono"
      "font-fira-sans"
      "font-hack-nerd-font"
      "font-ibm-plex-sans"
      "font-ibm-plex-mono"
      "font-inter"
      "font-jetbrains-mono"
      "font-monaspace"
      "font-permanent-marker"
      "font-space-mono"
      "ghostty"
      "home-assistant"
      "homebrew-app"
      "keka"
      "mitmproxy"
      "notion"
      "obsidian"
      "openlogi"
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
      "thaw"
      "vlc"
      "whatsapp"
      "zed"
      "zen"
    ];
  };
}
