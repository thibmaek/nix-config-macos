{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ctop
    fzf
  ];
}
