# nix-config-macos

My Nix config for macOS machines. Ideally merged with [thibmaek/nix-config-debian].

This configuration supports multiple machines with shared and machine-specific settings.

## Directory Structure

```
.
├── flake.nix              # Main flake configuration
├── hosts/                 # Machine-specific configurations
│   ├── payflip/          # Payflip laptop configuration
│   │   ├── default.nix   # Hostname definition
│   │   ├── homebrew.nix  # Machine-specific Homebrew packages
│   │   ├── packages.nix  # Machine-specific Nix packages
│   │   ├── programs.nix  # Machine-specific home-manager programs
│   │   └── system.nix    # Machine-specific system settings
│   └── mac-studio/       # Mac Studio configuration
│       ├── default.nix   # Hostname definition
│       ├── homebrew.nix  # Machine-specific Homebrew packages
│       ├── packages.nix  # Machine-specific Nix packages
│       ├── programs.nix  # Machine-specific home-manager programs
│       └── system.nix    # Machine-specific system settings
├── modules/               # Shared system modules
│   ├── nix-core.nix      # Core Nix settings
│   ├── pkgs.nix          # Package overlays
│   ├── programs.nix      # System programs
│   ├── system.nix        # Shared macOS system settings
│   └── homebrew.nix      # Shared Homebrew packages
└── home/                  # Home Manager configuration
    ├── default.nix       # Main home configuration
    ├── packages.nix      # Shared packages across all machines
    ├── programs.nix      # Program configurations
    └── shell.nix         # Shell configuration
```

## Installing

1. Clone this to `~/.config/nix`
2. Install Nix (using [det-sys](https://docs.determinate.systems/determinate-nix/)'s Nix)
3. Run one of the following commands:
   - Using Make (using autodetected hostname): `make build`
   - Auto-detect machine: `darwin-rebuild switch --flake ~/.config/nix#$(hostname)`
   - Specific machine: `darwin-rebuild switch --flake ~/.config/nix#Thibaults-Mac-Studio

## Building & Updating

### Using Make (recommended)

```bash
# Build for current machine (auto-detect)
make build

# Update flake and rebuild
make update

# Other commands
make check    # Check flake validity
make format   # Format Nix files
make clean    # Clean up old generations
```

### Using darwin-rebuild directly

```bash
# Build for current machine
sudo darwin-rebuild switch --flake ~/.config/nix#$(hostname)

# Build for specific host (e.g Thibaults-Mac-Studio)
sudo darwin-rebuild switch --flake ~/.config/nix#Thibaults-Mac-Studio
```

## Shared vs Machine-Specific Configuration

Each host inherits from shared configuration and can extend or override it with machine-specific settings.

### Home-Manager Configuration

#### Packages

- **Shared packages** (all machines): Edit `home/packages.nix`
- **Machine-specific packages**: Edit `hosts/<machine>/packages.nix`
- Both are merged together, so each machine gets shared + its own packages

#### Programs

- **Shared programs** (all machines): Edit `home/programs.nix` and `home/programs/*.nix`
- **Machine-specific programs**: Edit `hosts/<machine>/programs.nix`
- Host-specific programs can add new programs or override shared settings
- Programs include: git, starship, zsh, neovim, fzf, bat, direnv, zoxide, etc.

### System Configuration

#### Homebrew Casks/Brews

- **Shared apps** (all machines): Edit `modules/homebrew.nix`
- **Machine-specific apps**: Edit `hosts/<machine>/homebrew.nix`
- Both are merged together

#### System Settings

- **Shared settings** (all machines): Edit `modules/system.nix`
- **Machine-specific settings**: Edit `hosts/<machine>/system.nix`
- Host-specific settings can extend or override shared settings
