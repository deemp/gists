# file: flake.nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    haskell-flake.url = "github:srid/haskell-flake";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      imports = [ inputs.haskell-flake.flakeModule ];
      perSystem =
        {
          self',
          system,
          lib,
          config,
          pkgs,
          ...
        }:
        {
          haskellProjects.default = {
            basePackages = pkgs.haskell.packages.ghc910;

            # my-haskell-package development shell configuration
            devShell = {
              hlsCheck.enable = false;
              hoogle = false;
              tools = hp: {
                cabal-install = null;
                hlint = null;
                haskell-language-server = null;
                ghcid = null;
              };
            };

            # What should haskell-flake add to flake outputs?
            autoWire = [
              "packages"
              # "apps"
              # "checks"
            ]; # Wire all but the devShell
          };

          devShells.default = pkgs.mkShell {
            name = "my-haskell-package custom development shell";
            inputsFrom = [ config.haskellProjects.default.outputs.devShell ];
            buildInputs = [
              pkgs.haskell.packages.ghc910.haskell-language-server
              pkgs.cabal-install
            ];
          };
        };
    };
}
