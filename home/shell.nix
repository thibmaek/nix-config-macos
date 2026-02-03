{ ... }:

{
  # Shell aliases consolidated from home/default.nix and home/programs.nix
  home.shellAliases = {
    # Nix operations
    nxi = "nix flake new -t github:nix-community/nix-direnv .";

    # Directory navigation
    dl = "cd ~/Downloads";
    d = "cd ~/Desktop";
    here = "open $(pwd)";

    # Safe defaults
    rm = "trash";

    # Editor shortcuts
    n = "nvim";

    # Search utilities
    fzgrep = "grep --line-buffered --color=never -r \"\" *| fzf";
  };
}
