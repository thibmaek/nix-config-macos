# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Common Commands

- `make` or `make update` - Update flake inputs and rebuild the system
- `make build` - Build and switch to the new configuration using darwin-rebuild
- `darwin-rebuild switch --flake ~/.config/nix` - Manual system rebuild
- `nix flake update` - Update flake.lock with latest package versions
- `nixfmt flake.nix` - Format Nix files using the configured formatter

## Architecture Overview

This is a Nix Darwin configuration for macOS that uses flakes and home-manager. The configuration is split into several logical modules:

### Core Structure
- `flake.nix` - Main flake definition with inputs (nixpkgs, nix-darwin, home-manager) targeting aarch64-darwin
- `Makefile` - Convenience commands for common operations
- `modules/` - System-level configuration modules
- `home/` - User-level home-manager configuration

### Key Configuration Areas
- **System Configuration** (`modules/system.nix`) - macOS system defaults, user setup, dock/menubar settings
- **Package Management** (`modules/pkgs.nix`, `home/packages.nix`) - System and user package declarations
- **Program Configuration** (`home/programs.nix`) - Detailed program configurations including:
  - Zsh with oh-my-zsh, custom plugins, and shell integrations
  - Neovim with basic configuration and vim-plug
  - Development tools (git, fzf, bat, direnv, zoxide)
  - Custom shell aliases and PATH modifications

### Important Details
- Configuration targets user "thibmaek" on hostname "Thibaults-Mac-Studio"
- Uses nixpkgs-25.05-darwin branch for packages
- Home-manager integration with backup file extension ".bak"
- Custom zsh plugins fetched from GitHub (fzf-tab, syntax-highlighting, autosuggestions, ollama-completions)
- Shell aliases include `n` for nvim, `dl` for Downloads, `d` for Desktop
- Touch ID authentication enabled for sudo operations

## Development Workflow

When making changes:
1. Edit the appropriate .nix files in `modules/` or `home/`

The configuration automatically formats Nix files using nixfmt-rfc-style when building.
