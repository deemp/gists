{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/1fb781f4a148c19e9da1d35a4cbe15d0158afc4e";
    haskell-language-server.url = "github:haskell/haskell-language-server";
  };
  outputs = inputs: inputs.flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      hpkgs = pkgs.haskell.packages.ghc902;
      gwp = hpkgs.ghcWithPackages (ps: [ ps.acme-missiles ]);
      hlsNixpkgs = hpkgs.haskell-language-server;
      hlsGitHub = inputs.haskell-language-server.packages.${system}.haskell-language-server-902;
    in
    {
      devShells = {
        # GOOD
        # GHC with packages overrides GHC brought by HLS
        
        # nix develop .#ghcWithPackages1 -c which ghc
        # /nix/store/cxfj9pcgk1iy2y6kw2pn6ynrcnf54rmx-ghc-9.0.2-with-packages/bin/ghc
        ghcWithPackages1 = pkgs.mkShell {
          buildInputs = [ gwp hlsNixpkgs ];
        };
        
        # BAD
        # GHC brought by HLS overrides custom ghc with packages
        
        # nix develop .#ghcWithPackages2 -c which ghc
        # /nix/store/94g8rpkqzhcmnkm0j4fmrvs9nfcc6zif-ghc-9.0.2/bin/ghc
        ghcWithPackages2 = pkgs.mkShell {
          buildInputs = [ hlsNixpkgs gwp ];
        };
        
        # HLS from GitHub also brings its own GHC into a devshell.
        
        # nix develop .#hlsGitHub -c which ghc
        # /nix/store/94g8rpkqzhcmnkm0j4fmrvs9nfcc6zif-ghc-9.0.2/bin/ghc
        hlsGitHub = pkgs.mkShell {
          buildInputs = [ hlsGitHub ];
        };
      };
    });

  nixConfig = {
    extra-substituters = [
      "https://haskell-language-server.cachix.org"
    ];
    extra-trusted-public-keys = [
      "haskell-language-server.cachix.org-1:juFfHrwkOxqIOZShtC4YC1uT1bBcq2RSvC7OMKx0Nz8="
    ];
  };
}
