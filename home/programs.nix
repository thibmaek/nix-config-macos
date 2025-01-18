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
  zsh-customs = pkgs.stdenv.mkDerivation {
    name = "zsh-customs";
    phases = [ "buildPhase" ];
    buildPhase = ''
      mkdir -p $out/plugins
      cp -r ${fzf-tab} $out/plugins/fzf-tab
      cp -r ${zsh-syntax-highlighting} $out/plugins/zsh-syntax-highlighting
      cp -r ${zsh-autosuggestions} $out/plugins/zsh-autosuggestions
    '';
  };

in {
  programs = {
    fzf = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
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
      options = ["--cmd=cd"];
    };

    starship = {
      enable = true;
      enableBashIntegration = false;
      enableZshIntegration = true;
      settings = {
        character.error_symbol = "✗";
        hostname.format = "[$hostname]($style) in ";
        os.disabled = true;
        container.disabled = true;
        username.disabled = true;
        custom.docker = {
          description = "Shows the Docker symbol if the current directory has Dockerfile or docker-compose files";
          files = ["Dockerfile" "docker-compose.yaml" "compose.yaml"];
          when = "command -v docker &> /dev/null; exit (echo $?);";
          command = "echo 🐳";
        };
      };
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

      initExtra = ''
        if type brew &>/dev/null; then
          FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
          autoload -Uz compinit
          compinit
        fi

        source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"
        source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"

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
        ];
        custom = "${zsh-customs}";
      };
    };
  };
}
