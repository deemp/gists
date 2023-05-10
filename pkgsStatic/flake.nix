{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils/cfacdce06f30d2b68473a46042957675eebb3401";
    nixpkgs.url = "github:NixOS/nixpkgs/12ba1a5f90b16acdca741ac82d8204b3ec8c2aaf";
    jose = {
      url = "github:frasertweedale/hs-jose";
      flake = false;
    };
    servant = {
      url = "github:deemp/servant";
      flake = false;
    };
  };
  outputs = inputs: inputs.flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = inputs.nixpkgs.legacyPackages.${system};

      back = "back";
      test = "test";


      inherit (pkgs.haskell.lib)
        # dontCheck - skip test
        dontCheck
        dontHaddock
        dontBenchmark
        # override deps of a package
        # see what can be overriden - https://github.com/NixOS/nixpkgs/blob/0ba44a03f620806a2558a699dba143e6cf9858db/pkgs/development/haskell-modules/generic-builder.nix#L13
        overrideCabal
        unmarkBroken
        ;
      override = pkgs_: {
        overrides = self: super:
          let modify = drv: pkgs.lib.pipe drv [ dontBenchmark dontCheck ]; in
          {
            lzma = modify super.lzma;
            openapi3 = modify (unmarkBroken super.openapi3);

            servant-queryparam-core = (super.callCabal2nix "servant-queryparam-core" "${inputs.servant.outPath}/servant-queryparam/servant-queryparam-core" { });
            servant-queryparam-server = (super.callCabal2nix "servant-queryparam-server" "${inputs.servant.outPath}/servant-queryparam/servant-queryparam-server" {
              inherit (self) servant-queryparam-core;
            });
            servant-queryparam-client = (super.callCabal2nix "servant-queryparam-client" "${inputs.servant.outPath}/servant-queryparam/servant-queryparam-client" {
              inherit (self) servant-queryparam-core;
            });
          } //
          (
            let
              mkPackage = name: path: deps: depsLib: overrideCabal
                (dontCheck (dontHaddock (dontBenchmark (super.callCabal2nix back path deps))))
                (x: {
                  # we can combine the existing deps and new deps
                  # we should write the new deps before the existing deps to override them
                  # these deps will be in haskellPackages.myPackage.getCabalDeps.librarySystemDepends
                  librarySystemDepends = depsLib ++ (x.librarySystemDepends or [ ]);

                  testHaskellDepends = [
                    super.tasty-discover
                  ] ++ (x.testHaskellDepends or [ ]);
                });
              backDepsLib = (__attrValues { inherit (pkgs_) zlib libpqxx; });
              testDepsLib = backDepsLib;
            in
            {
              "${back}" = mkPackage back ./${back} { } backDepsLib;
              "${test}" = mkPackage test ./${test} { "${back}" = self."${back}"; } testDepsLib;
            }
          );
      };
      ghcVersion = "ghc927";
      spkgs = pkgs.pkgsStatic;
      hpkgs = spkgs.haskell.packages.${ghcVersion};
      getHaskellPackagesDeps = someHaskellPackages: with pkgs.lib.lists; (subtractLists someHaskellPackages (concatLists (map (package: concatLists (__attrValues package.getCabalDeps)) someHaskellPackages)));
      ghcForPackages = hpkgs_: override_: localHaskellPackageNames: (hpkgs_.override override_).ghcWithPackages (ps: getHaskellPackagesDeps (map (x: ps.${x}) localHaskellPackageNames));
      ghc = ghcForPackages hpkgs (override spkgs) [ back test ];

      tools = [
        pkgs.cabal-install
        # ghc should go before haskell-language-server - https://github.com/NixOS/nixpkgs/issues/225895
        ghc
        pkgs.haskell-language-server
        pkgs.hpack
      ];

      devShells.default = pkgs.mkShell {
        buildInputs = tools;
      };
    in
    {
      inherit devShells;
    });
}
