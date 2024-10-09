{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
    devshell.url = "github:deemp/devshell";
  };
  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;
      imports = [ inputs.devshell.flakeModule ];

      perSystem =
        {
          self',
          system,
          pkgs,
          ...
        }:
        {
          packages.default = pkgs.writeShellApplication {
            name = "run";
            meta.description = "Run a NixOS shell";
            runtimeInputs = [ pkgs.nixos-shell ];
            text = "nixos-shell -I nixpkgs=${inputs.nixpkgs} .#nixosConfigurations.myNixOS";
          };
          devshells.default = {
            commands = {
              tools = [ pkgs.nixos-shell ];
              nixos = [ { package = self'.packages.default; } ];
            };
          };
        };

      flake.nixosConfigurations.default = inputs.nixpkgs.lib.nixosSystem {
        # system = builtins.currentSystem;
        system = "x86_64-linux";
        modules = [
          (
            { pkgs, ... }:
            {
              services.openssh.enable = true;
              services.openssh.settings.PermitRootLogin = "yes";
            }
          )
        ];
      };
    };
}
