# NixOS Configuration

Personal NixOS configuration using flakes and home-manager.

## Hosts

- **thinkpad** - ThinkPad laptop
- **carbon** - Carbon laptop

## Quick Commands

```bash
# Rebuild current system
nixrebuild

# Update flake inputs
nix flake update

# Test configuration without switching
sudo nixos-rebuild test --flake ~/.config/nixos#<hostname>
```

## Setting Up a Fresh NixOS Install

After installing NixOS (base installation with NetworkManager):

### 1. Connect to WiFi

```bash
nmtui
```

### 2. Clone This Repository

```bash
nix-shell -p git

mkdir -p ~/.config
git clone https://github.com/michelmattos/my-nix-dotfiles.git ~/.config/nixos
```

### 3. Generate Hardware Configuration

```bash
nixos-generate-config --show-hardware-config > ~/.config/nixos/hosts/<hostname>/hardware-configuration.nix
```

### 4. Rebuild

```bash
sudo nixos-rebuild switch --flake ~/.config/nixos#<hostname>
reboot
```

## After Rebuild

### Install Development Tools

```bash
mise install
```

## Repository Structure

```
flake.nix                    # Entry point, defines all hosts
home.nix                     # User-level home-manager config
hosts/
  <hostname>/
    configuration.nix        # Host-specific system config
    hardware-configuration.nix
modules/
  system/                    # Shared system modules
  desktop/                   # Window manager and fonts
  programs/                  # User program configs
```
