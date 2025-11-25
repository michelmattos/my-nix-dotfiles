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
│   ├── configuration.nix    # Host-specific system config (imports system/ and niri)
│   └── hardware-configuration.nix
├── home.nix                 # User-level home-manager config for 'michel'
└── modules/
    ├── system/              # System-level NixOS modules (imported in configuration.nix)
    │   ├── common.nix       # Boot, locale, garbage collection, nix-ld
    │   ├── networking.nix
    │   └── users.nix
    ├── desktop/             # Desktop environment modules
    │   ├── niri/            # Niri window manager (system-level, dotfiles linked in home.nix)
    │   └── fonts/           # Font configuration (user-level, imported in home.nix)
    └── programs/            # User-level program configurations (imported in home.nix)
```

### Flake Inputs

- **nixpkgs**: nixos-unstable channel
- **home-manager**: Manages user environment (follows nixpkgs)
- **zen-browser**: Custom browser flake (follows nixpkgs)
- **astronvim-template**: AstroNvim config template (non-flake)

### Key Configuration Details

- **Host**: thinkpad (x86_64-linux)
- **System modules** imported in `hosts/thinkpad/configuration.nix`: common, networking, users, niri
- **Home-manager modules** imported in `home.nix`: all programs under `modules/programs/` and fonts
- **Special args**: All flake inputs passed to home-manager via `extraSpecialArgs`
- **Niri dotfiles**: Sourced from `modules/desktop/niri/dotfiles` via `xdg.configFile` in home.nix
- **Default editor**: helix (`EDITOR=hx`)
- **Dark mode**: Configured via GTK theme and dconf settings in home.nix

### Module Organization Pattern

For programs, add a new module in `modules/programs/[PROGRAM]/` with:
- `[PROGRAM].nix` - Program configuration using home-manager options
- `dotfiles/` - Optional directory for raw config files (linked via `xdg.configFile`)

Then import the module in `home.nix`.

## Important Notes

- Assume your knowledge about NixOS, flakes and niri are not up-to-date. Use search and web tools to find the most up-to-date info
- Experimental features enabled: `nix-command` and `flakes`
- Unfree packages are allowed
- `nix-ld` is enabled for running dynamic binaries
- LUKS encryption is configured in common.nix
- Automatic garbage collection runs weekly (deletes generations older than 30 days)
- IMPORTANT: use `jj` instead of `git`
