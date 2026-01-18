{ ... }:
{
  # https://github.com/nix-darwin/nix-darwin/blob/master/modules/system/defaults/dock.nix
  system.defaults.dock = {
    tilesize = 36;
    magnification = true;
    largesize = 20;
    wvous-br-corner = 12;
  };
}
