{ pkgs, ... }:

{
  programs.lazyvim = {
    enable = true;

    extras = {
      lang.nix.enable = true;
      lang.python = {
        enable = true;
      };
      lang.go = {
        enable = true;
        installDependencies = true;
      };
    };

    extraPackages = with pkgs; [
      alejandra
      nixd
      statix
    ];

    config = {
      options = ''
        vim.o.expandtab = true
        vim.o.shiftwidth = 2
        vim.o.smartindent = true
        vim.o.smarttab = true
        vim.o.softtabstop = 0
        vim.o.tabstop = 2
      '';
    };
  };
}
