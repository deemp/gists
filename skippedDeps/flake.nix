{
  inputs = {
    nixpkgs_.url = "github:deemp/flakes?dir=source-flake/nixpkgs";
    nixpkgs.follows = "nixpkgs_/nixpkgs";
    flake-utils_.url = "github:deemp/flakes?dir=source-flake/flake-utils";
    flake-utils.follows = "flake-utils_/flake-utils";
  };
  outputs = inputs: inputs.flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = inputs.nixpkgs.legacyPackages.${system};
    in
    {
      packages = {
        default = pkgs.haskell.packages.ghc925.callCabal2nix "telegram-bot-api" ./. { };
      };
    });

  nixConfig = {
    extra-substituters = [
      "https://haskell-language-server.cachix.org"
      "https://nix-community.cachix.org"
      "https://cache.iog.io"
      "https://deemp.cachix.org"
    ];
    extra-trusted-public-keys = [
      "haskell-language-server.cachix.org-1:juFfHrwkOxqIOZShtC4YC1uT1bBcq2RSvC7OMKx0Nz8="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      "deemp.cachix.org-1:9shDxyR2ANqEPQEEYDL/xIOnoPwxHot21L5fiZnFL18="
    ];
  };
}


# :lf nixpkgs
# :lf .
# legacyPackages.x86_64-linux.lib.lists.flatten (builtins.attrValues packages.x86_64-linux.default.getCabalDeps)

# [ 
# aeson-2.0.3.0
# aeson-pretty-0.8.9
# cron-0.7.0
# hashable-1.4.2.0
# http-api-data-0.4.3
# http-client-0.7.13.1
# http-client-tls-0.3.6.1
# monad-control-1.0.3.1
# pretty-show-1.10
# profunctors-5.6.2
# servant-0.19.1
# servant-client-0.19
# servant-multipart-api-0.12.1
# servant-multipart-client-0.12.1
# servant-server-0.19.2
# split-0.2.3.5
# unordered-containers-0.2.19.1
# warp-3.3.23
# warp-tls-3.3.4
# ]

# missing - stm, text, bytestring, etc.
# perhaps because they're included into present packages