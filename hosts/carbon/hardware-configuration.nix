# PLACEHOLDER - Replace this file with the output of:
#   nixos-generate-config --show-hardware-config
# Run this command on the carbon laptop during NixOS installation.
#
# NOTE: If using encrypted partitions (LUKS), ensure all LUKS devices are
# listed here. For example, thinkpad has two: one for root and one for swap.

{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  # TODO: Replace these with actual values from nixos-generate-config
  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];  # Change to kvm-amd if AMD CPU
  boot.extraModulePackages = [ ];

  # TODO: Replace with actual UUIDs from carbon's disk
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/REPLACE-WITH-ROOT-UUID";
      fsType = "ext4";
    };

  # TODO: Replace with actual LUKS device UUIDs if using encryption
  # You may have multiple LUKS devices (e.g., root + swap)
  boot.initrd.luks.devices."luks-REPLACE-UUID".device = "/dev/disk/by-uuid/REPLACE-WITH-LUKS-UUID";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/REPLACE-WITH-BOOT-UUID";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/REPLACE-WITH-SWAP-UUID"; }
    ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
