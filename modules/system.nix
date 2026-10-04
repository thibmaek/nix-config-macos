{ hostname, user, ... }:

###################################################################################
#
#  Shared macOS system configuration across all machines
#
#  All the configuration options are documented here:
#    https://nix-darwin.github.io/nix-darwin/manual/
#
###################################################################################
{
  users.users."${user}" = {
    home = "/Users/${user}";
    description = user;
  };

  networking = {
    hostName = hostname;
    computerName = hostname;
  };

  system = {
    stateVersion = 5;
    primaryUser = "${user}";

    # activationScripts are executed every time you boot the system or run `nixos-rebuild` / `darwin-rebuild`.
    activationScripts.text = ''
      # activateSettings -u will reload the settings from the database and apply them to the current session,
      # so we do not need to logout and login again to make the changes take effect.
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    defaults = {
      controlcenter = {
        BatteryShowPercentage = true;
      };

      dock = {
        show-recents = false;
      };

      finder = {
        NewWindowTarget = "Other";
        NewWindowTargetPath = "file:///Users/${user}/Downloads";
        ShowExternalHardDrivesOnDesktop = true;
        ShowHardDrivesOnDesktop = false;
        ShowRemovableMediaOnDesktop = true;
      };

      menuExtraClock.Show24Hour = true;

      NSGlobalDomain = {
        "com.apple.swipescrolldirection" = false;
        "com.apple.trackpad.scaling" = 2.2;
        AppleEnableMouseSwipeNavigateWithScrolls = false;
        AppleEnableSwipeNavigateWithScrolls = false;
        AppleInterfaceStyleSwitchesAutomatically = true;
        ApplePressAndHoldEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
        NSTableViewDefaultSizeMode = 1;
        PMPrintingExpandedStateForPrint = true;
        PMPrintingExpandedStateForPrint2 = true;
      };

      smb.NetBIOSName = hostname;

      trackpad = {
        Clicking = true;
      };
    };
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  time = {
    timeZone = "Europe/Brussels";
  };
}
