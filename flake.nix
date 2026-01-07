{
  description = "NixOS configuratio";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    astronvim-template = {
      url = "github:AstroNvim/template";
      flake = false;
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.thinkpad = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/thinkpad/configuration.nix

        # TODO: Remove this overlay once nixpkgs PR #476565 is merged
        # https://github.com/NixOS/nixpkgs/pull/476565
        { nixpkgs.overlays = [ (import ./modules/programs/oculante/libaom-fix-overlay.nix) ]; }

        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.michel = import ./home.nix;
          home-manager.extraSpecialArgs = {
            inherit inputs;
            hostname = "thinkpad";
          };
        }
      ];
    };

    nixosConfigurations.carbon = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/carbon/configuration.nix

        # TODO: Remove this overlay once nixpkgs PR #476565 is merged
        # https://github.com/NixOS/nixpkgs/pull/476565
        { nixpkgs.overlays = [ (import ./modules/programs/oculante/libaom-fix-overlay.nix) ]; }

        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.michel = import ./home.nix;
          home-manager.extraSpecialArgs = {
            inherit inputs;
            hostname = "carbon";
          };
        }
      ];
    };
  };
}
