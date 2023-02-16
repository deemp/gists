{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/cbe419ed4c8f98bd82d169c321d339ea30904f1f";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  outputs = inputs: inputs.flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      hpkgs = pkgs.haskell.packages.ghc902;
    in
    {
      devShells.default =
        hpkgs.developPackage {
          root = ./.;
          modifier = drv:
            pkgs.haskell.lib.addBuildTools drv (with hpkgs; [
              cabal-install
              ghcid
            ]);
        };
    }
  );
}
