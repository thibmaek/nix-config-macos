# AGENTS.md

This file provides guidance for agentic coding tools (Claude Code, Cursor, Mistral Vibe) to understand and work with this Nix configuration repository.

## Repository Overview

This is a Nix configuration repository for managing system and home manager configurations across multiple macOS hosts using Nix Flakes.

### Key Features
- **Multi-host configuration**: Separate configurations for `mac-studio` and `payflip` hosts
- **Nix Flakes**: Uses declarative, reproducible Nix configurations
- **Home Manager**: Manages user-level configurations
- **Homebrew**: Manages macOS packages via Homebrew

## Directory Structure

```
/
├── home/                  # Home Manager configurations
│   ├── programs/          # Program-specific home configurations
│   │   ├── neovim/        # Neovim configuration
│   │   ├── git.nix        # Git configuration
│   │   └── starship.nix   # Starship prompt configuration
│   ├── default.nix        # Main home configuration
│   ├── packages.nix       # Home packages
│   ├── programs.nix       # Home programs
│   ├── README.md          # Home configuration documentation
│   └── shell.nix          # Shell configuration
├── hosts/                 # Host-specific configurations
│   ├── mac-studio/       # macOS Studio configuration
│   │   ├── home-manager/  # Home Manager configs for mac-studio
│   │   ├── default.nix    # Main system configuration
│   │   ├── homebrew.nix   # Homebrew packages
│   │   └── system.nix     # System packages and services
│   └── payflip/          # Payflip host configuration (similar structure)
├── modules/               # Reusable Nix modules
│   ├── homebrew.nix      # Homebrew module
│   ├── nix-core.nix      # Core Nix configuration
│   ├── pkgs.nix          # Package overrides
│   ├── programs.nix      # Program modules
│   ├── README.md         # Modules documentation
│   └── system.nix        # System modules
├── flake.lock            # Flake lock file (auto-generated)
├── flake.nix             # Main flake definition
├── Makefile              # Build and deployment commands
├── README.md             # Main repository documentation
└── treefmt.toml          # Code formatting configuration
```

## Flake Structure

The `flake.nix` file defines the flake with:
- **Inputs**: Nixpkgs and Home Manager
- **Outputs**: System and home configurations for each host

### Flake Inputs
- `nixpkgs`: Nix package collection
- `home-manager`: Home Manager for user-level configurations

### Flake Outputs
- `nixConfigurations.<host>`: System configurations for each host
- `homeConfigurations.<host>`: Home configurations for each host

## Common Tasks

### Building and Deploying

Use the Makefile for common operations:

```bash
# Build all configurations
make build

# Update the installed packages from Flake
make update
```

### Manual Operations

```bash
# Build a specific host
nix build .#nixConfigurations.mac-studio.config.system.build.toplevel

# Deploy a specific host
nix build .#nixConfigurations.mac-studio.config.system.build.toplevel --accept-flake-config && sudo nix copy --to 'root@mac-studio' /nix/store/* && ssh root@mac-studio 'sudo nix-env -p /nix/var/nix/profiles/system -i /nix/store/*'

# Enter development shell
nix develop
```

## Configuration Patterns

### Module System

The repository uses a modular approach:
- **`modules/`**: Contains reusable Nix modules
- **`hosts/`**: Host-specific configurations that import modules
- **`home/`**: Home Manager configurations

### Homebrew Integration

Homebrew packages are managed via the `homebrew.nix` module in both:
- `modules/homebrew.nix`: Module definition
- `hosts/<host>/homebrew.nix`: Host-specific Homebrew configurations

### Program Configurations

Programs are configured in:
- `home/programs/`: Home Manager program configurations
- `modules/programs.nix`: System-level program modules

## Best Practices for Agentic Coding

### 1. Understanding the Configuration

Before making changes:
1. Read the `README.md` files in each directory
2. Examine the `flake.nix` to understand the structure
3. Check host-specific configurations in `hosts/`

### 2. Making Changes

**For system-wide changes:**
- Modify files in `modules/`
- Update host-specific files in `hosts/` as needed

**For user-level changes:**
- Modify files in `home/`
- Update host-specific home configurations

**For host-specific changes:**
- Modify files in `hosts/<host>/`
- Avoid duplicating code - extract to modules if reusable

### 3. Testing Changes

```bash
# Always build before deploying
nix build .#nixConfigurations.<host>.config.system.build.toplevel

# Test home configurations
nix build .#homeConfigurations.<host>.activationPackage
```

### 4. Deployment

Use the Makefile targets or manual deployment commands shown above.

## Important Files

### `flake.nix`
Main flake definition. Contains:
- Inputs (nixpkgs, home-manager)
- Outputs (system and home configurations)
- Output definitions for each host

### `Makefile`
Contains convenient targets for:
- Building configurations
- Deploying to hosts
- Checking for changes
- Formatting code
- Updating dependencies

### `treefmt.toml`
Code formatting configuration for maintaining consistent style.

## Troubleshooting

### Common Issues

1. **Flake lock conflicts**: Run `make update` to update dependencies
2. **Homebrew package issues**: Check `hosts/<host>/homebrew.nix`
3. **Configuration errors**: Use `nix flake metadata` to check for issues

### Debugging Commands

```bash
# Check flake metadata
nix flake metadata

# Show evaluation dependencies
nix flake metadata --json | jq '.locks | keys'

# Test a specific configuration
nix eval .#nixConfigurations.<host>.config.system.build.toplevel
```

## Contributing

When adding new configurations:
1. Add to the appropriate module in `modules/`
2. Import the module in host-specific configurations
3. Update documentation as needed
4. Test with `make build`
5. Deploy to test hosts

## References

- [Nix Flakes](https://nixos.wiki/wiki/Flakes)
- [Home Manager](https://github.com/nix-community/home-manager)
- [Nix Pills](https://nixos.org/guides/nix-pills/) - Nix learning resource
