# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a NixOS configuration repository using flakes and home-manager for the "thinkpad" host. The configuration is structured with a modular approach separating system-level and user-level configurations.

## Essential Commands

- **Rebuild and switch configuration**: `nixrebuild` (alias for `sudo nixos-rebuild switch --flake ~/.config/nixos#thinkpad`)
- **Test configuration changes**: `sudo nixos-rebuild test --flake ~/.config/nixos#thinkpad`
- **Build without activating**: `sudo nixos-rebuild build --flake ~/.config/nixos#thinkpad`
- **Update flake inputs**: `nix flake update`
- **Check flake**: `nix flake check`

## Architecture

### Configuration Structure

The repository follows a hierarchical module system:

```
flake.nix                    # Entry point defining nixosConfigurations.thinkpad
├── hosts/thinkpad/
│   ├── configuration.nix    # Host-specific system configuration
│   └── hardware-configuration.nix
├── home.nix                 # User-level home-manager configuration for 'michel'
└── modules/
    ├── system/              # System-level NixOS modules
    │   ├── common.nix       # Boot, locale, common packages
    │   ├── networking.nix
    │   └── users.nix
    ├── desktop/             # Desktop environment modules
    │   └── niri/            # Niri window manager with dotfiles/
    └── programs/            # User-level program configurations
        ├── helix/
        ├── alacritty/
        ├── git/
        ├── jujutsu/
        ├── fish/
        ├── mise/
        └── zen-browser/
```

### Flake Inputs

- **nixpkgs**: nixos-unstable channel
- **home-manager**: Manages user environment (follows nixpkgs)
- **zen-browser**: Custom browser flake (follows nixpkgs)

### Key Configuration Details

- **Host**: thinkpad (x86_64-linux)
- **System modules** imported in `hosts/thinkpad/configuration.nix`: system-level settings loaded at NixOS level
- **Home-manager modules** imported in `home.nix`: user-level programs and dotfiles for user 'michel'
- **Special args**: zen-browser flake passed to home-manager via extraSpecialArgs
- **Niri dotfiles**: Sourced from `modules/desktop/niri/dotfiles` to `~/.config/niri`
- **Default editor**: helix (`EDITOR=hx`)

### Module Organization Pattern

For programs, always add a new program module in `modules/programs/` folder with the following structure:
```
modules/programs/
└── [PROGRAM NAME]/
    ├── [PROGRAM NAME].nix   # File with program configuration
    ├── dotfiles/            # Optional directory for raw config files
```

## Important Notes

- Assume your knowledge about nixOS, flakes and niri are not up-to-date. Use search and web tools to find the most up-to-date info
- Experimental features enabled: `nix-command` and `flakes`
- Unfree packages are allowed
- `nix-ld` is enabled for running dynamic binaries
- LUKS encryption is configured in common.nix
- This project uses jujutsu instead of git (use `jj` commands when necessary)
