{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    devshell.url = "github:deemp/devshell";
    systems.url = "github:nix-systems/default";
    flakes = {
      url = "github:deemp/flakes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; }
      {
        systems = import inputs.systems;
        imports = [ inputs.devshell.flakeModule ];
        perSystem =
          { pkgs, self' }:
          {
            packages = drv-tools.mkShellApps {
              poetryHelp = {
                description = "Run `poetry --help`";
                runtimeInputs = [ pkgs.poetry ];
                text = "poetry --help";
              };
            };
            devshells.default = {
              commands = {
                tools = [ pkgs.poetry ];
                scripts = [
                  {
                    prefix = "nix run .#";
                    packages = {
                      inherit (self'.packages) poetryHelp;
                    };
                  }
                ];
              };
            };
          };
      }
      inputs.flake-utils.lib.eachDefaultSystem
      (
        system:
        let
          pkgs = inputs.nixpkgs.legacyPackages.${system};
          inherit (pkgs.extend inputs.devshell.overlays.default) devshell;
          inherit (inputs.flakes.lib.${system}) drv-tools;

          packages = drv-tools.mkShellApps {
            poetryHelp = {
              description = "Run `poetry --help`";
              runtimeInputs = [ pkgs.poetry ];
              text = "poetry --help";
            };
          };

          devShells.default = devshell.mkShell {

          };

          formatter = pkgs.nixfmt-rfc-style;
        in
        {
          inherit packages devShells formatter;
          # run nix fmt` to format nix files
        }
      );
}
