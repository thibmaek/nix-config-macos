{ pkgs, ... }:

let
  # Ollama completions are not in nixpkgs, so we fetch them manually
  zsh-ollama-completions = pkgs.fetchFromGitHub {
    owner = "ocodo";
    repo = "ollama_zsh_completion";
    rev = "main";
    sha256 = "sha256-HjKVLDmJyCXwmAmYaHAuCcy8rC9274e5UaIt4acnq4Q=";
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

    eza = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      autocd = true;

      # ZSH plugins managed via home-manager
      plugins = [
        {
          name = "fzf-tab";
          src = pkgs.zsh-fzf-tab;
          file = "share/fzf-tab/fzf-tab.plugin.zsh";
        }
        {
          name = "zsh-syntax-highlighting";
          src = pkgs.zsh-syntax-highlighting;
          file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
        }
        {
          name = "zsh-autosuggestions";
          src = pkgs.zsh-autosuggestions;
          file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
        }
        {
          name = "ollama";
          src = zsh-ollama-completions;
          file = "ollama_zsh_completion.plugin.zsh";
        }
      ];

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
          "eza"
        ];
      };
    };
  };
}
