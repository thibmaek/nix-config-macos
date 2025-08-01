{ pkgs, ... }:

let
  fzf-tab = pkgs.fetchFromGitHub {
    owner = "Aloxaf";
    repo = "fzf-tab";
    rev = "v1.1.2";
    sha256 = "sha256-Qv8zAiMtrr67CbLRrFjGaPzFZcOiMVEFLg1Z+N6VMhg=";
  };
  zsh-syntax-highlighting = pkgs.fetchFromGitHub {
    owner = "zsh-users";
    repo = "zsh-syntax-highlighting";
    rev = "0.8.0";
    sha256 = "sha256-iJdWopZwHpSyYl5/FQXEW7gl/SrKaYDEtTH9cGP7iPo=";
  };
  zsh-autosuggestions = pkgs.fetchFromGitHub {
    owner = "zsh-users";
    repo = "zsh-autosuggestions";
    rev = "v0.7.1";
    sha256 = "sha256-vpTyYq9ZgfgdDsWzjxVAE7FZH4MALMNZIFyEOBLm5Qo=";
  };
  zsh-ollama-completions = pkgs.fetchFromGitHub {
    owner = "ocodo";
    repo = "ollama_zsh_completion";
    rev = "main";
    sha256 = "sha256-HjKVLDmJyCXwmAmYaHAuCcy8rC9274e5UaIt4acnq4Q=";
  };
  zsh-customs = pkgs.stdenv.mkDerivation {
    name = "zsh-customs";
    phases = [ "buildPhase" ];
    buildPhase = ''
      mkdir -p $out/plugins
      cp -r ${fzf-tab} $out/plugins/fzf-tab
      cp -r ${zsh-syntax-highlighting} $out/plugins/zsh-syntax-highlighting
      cp -r ${zsh-autosuggestions} $out/plugins/zsh-autosuggestions
      cp -r ${zsh-ollama-completions} $out/plugins/ollama
    '';
  };

in
{
  programs = {
    git = import ./programs/git.nix;
    starship = import ./programs/starship.nix;

    fzf = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        batdiff
        batman
        batpipe
        prettybat
      ];
    };

    yt-dlp.enable = true;
    htop.enable = true;

    direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      extraConfig = ''
        set tabstop=2
        set shiftwidth=2
        set softtabstop=0
        set noexpandtab
        set smartindent
        set smarttab
        set rtp+=/opt/homebrew/opt/fzf

        call plug#begin()
        Plug 'nanotee/zoxide.vim'
        call plug#end()
      '';
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      options = [ "--cmd=cd" ];
    };

    command-not-found.enable = true;

    eza = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      autocd = true;

      shellAliases = {
        nxi = "nix flake new -t github:nix-community/nix-direnv .";
      };

      initContent = ''
        if type brew &>/dev/null; then
          FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
          autoload -Uz compinit
          compinit
        fi

        zstyle ':omz:update' mode auto

        if [ -f $HOME/.zshrc.local ]; then
          source $HOME/.zshrc.local
        fi
      '';

      oh-my-zsh = {
        enable = true;
        plugins = [
          "docker"
          "docker-compose"
          "git"
          "command-not-found"
          "eza"
          "fzf-tab"
          "zsh-autosuggestions"
          "zsh-syntax-highlighting"
          "ollama"
        ];
        custom = "${zsh-customs}";
      };
    };
  };
}
