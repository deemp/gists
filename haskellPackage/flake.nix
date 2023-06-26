{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    sv2v = {
      url = "github:zachjs/sv2v";
      flake = false;
    };
  };
  outputs = inputs: inputs.flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      inherit (pkgs.haskell.lib) overrideCabal justStaticExecutables;
      ghcVersion = "928";
      hpkgs = pkgs.haskell.packages."ghc${ghcVersion}";

      packageName = "sv2v";

      # executableToolDepends - from "sv2v" expression in https://raw.githubusercontent.com/NixOS/nixpkgs/nixos-unstable/pkgs/development/haskell-modules/hackage-packages.nix
      package = overrideCabal (hpkgs.callCabal2nix packageName inputs.sv2v.outPath { })
        (x: { executableToolDepends = [ pkgs.alex pkgs.happy ] ++ (x.executableToolDepends or [ ]); });

      packages = {
        default = justStaticExecutables package;
        inherit package;
      };
    in
    {
      inherit packages;
    }
  );
}
