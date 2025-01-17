{ hostname, user, ... }:

###################################################################################
#
#  macOS's System configuration
#
#  All the configuration options are documented here:
#    https://daiderd.com/nix-darwin/manual/index.html#sec-options
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

    # activationScripts are executed every time you boot the system or run `nixos-rebuild` / `darwin-rebuild`.
    activationScripts.postUserActivation.text = ''
      # activateSettings -u will reload the settings from the database and apply them to the current session,
      # so we do not need to logout and login again to make the changes take effect.
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    defaults = {
      menuExtraClock.Show24Hour = true;

      smb.NetBIOSName = hostname;

      NSGlobalDomain = {
        AppleEnableMouseSwipeNavigateWithScrolls =  false;
        AppleEnableSwipeNavigateWithScrolls = false;
        AppleInterfaceStyleSwitchesAutomatically = true;
        ApplePressAndHoldEnabled = false;
        NSTableViewDefaultSizeMode = 1;
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
        PMPrintingExpandedStateForPrint = true;
        PMPrintingExpandedStateForPrint2 = true;
      };

      dock = {
        show-recents = false;
      };
    };
  };

  security.pam.enableSudoTouchIdAuth = true;
}
