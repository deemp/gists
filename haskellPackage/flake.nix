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
      pname = "sv2v";
      package = pkgs.haskellPackages.callCabal2nix pname inputs.sv2v.outPath { };
      packages = {
        default = pkgs.haskell.lib.justStaticExecutables package;
        inherit package;
      };
    in
    {
      inherit packages;
    }
  );
}
