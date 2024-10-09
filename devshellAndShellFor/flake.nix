{
  inputs = {
    flake-utils_.url = "github:deemp/flakes?dir=source-flake/flake-utils";
    flake-utils.follows = "flake-utils_/flake-utils";
    nixpkgs_.url = "github:deemp/flakes?dir=source-flake/nixpkgs";
    nixpkgs.follows = "nixpkgs_/nixpkgs";
    devshell.url = "github:numtide/devshell";
  };
  outputs = inputs: inputs.flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      devshell = inputs.devshell.legacyPackages.${system};

      packageName = "package";
      packageName1 = "${packageName}1";
      packageName2 = "${packageName}2";
      ghcVersion = "ghc945";

      # select a Haskell package set for a specified GHC version
      hpkgs = pkgs.haskell.packages.${ghcVersion};

      # # Provide overrides
      # # https://nixos.wiki/wiki/Haskell#Overrides
      # # An override should include a local package into the Haskell package set
      override = {
        overrides = self: super: {
          "${packageName1}" = pkgs.haskell.lib.overrideCabal (self.callCabal2nix packageName1 ./${packageName1} { }) (x: {
            libraryToolDepends = [ pkgs.zlib ] ++ (x.libraryToolDepends or [ ]);
          });
          "${packageName2}" = self.callCabal2nix packageName2 ./${packageName2} { "${packageName1}" = self.${packageName1}; };
        };
      };

      hpkgs_ = hpkgs.override override;

      devShells.shellFor = hpkgs_.shellFor {
        packages = ps: [ ps.${packageName1} ps.${packageName2} ];
        withHoogle = true;
      };

      devShells.default = devshell.mkShell {
        bash.extra = ''
          cabal build all
        '';
        # use packagesFrom if you need a combined devShell: shellFor + devshell
        # otherwise, direnv can run multiple devshells
        packagesFrom = [ devShells.shellFor ];
        packages = [ pkgs.hpack ];
        commands = [
          (let cabal = pkgs.cabal-install; in { name = cabal.pname; help = cabal.meta.description; package = cabal; category = "tools"; })
          (let hls = hpkgs.haskell-language-server; in { name = hls.pname; help = hls.meta.description; package = hls; category = "tools"; })
        ];
      };
      
      devShells.another = pkgs.mkShell {
        shellHook = ''
          ${pkgs.hello}/bin/hello
          export P=1
        '';
      };
    in
    {
      inherit devShells;
    });
}
