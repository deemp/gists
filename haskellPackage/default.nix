{ pkgs ? import <nixpkgs> { system = builtins.currentSystem; } }:
let
  pname = "sv2v";
  version = "0.0.11";
  src = pkgs.fetchFromGitHub {
    owner = "zachjs";
    repo = "sv2v";
    rev = "v${version}";
    sha256 = "sha256-1wyuzAAGXe+FybnutlmZbA2jLjQzmr4fI3rZfmEoCdY=";
  };
  inherit (pkgs.haskell.lib) overrideCabal justStaticExecutables;
  ghcVersion = "928";
  hpkgs = pkgs.haskell.packages."ghc${ghcVersion}";
  # executableToolDepends - from "sv2v" expression in https://raw.githubusercontent.com/NixOS/nixpkgs/nixos-unstable/pkgs/development/haskell-modules/hackage-packages.nix
  package = overrideCabal (hpkgs.callCabal2nix pname src.outPath { })
    (x: { executableToolDepends = [ pkgs.alex pkgs.happy ] ++ (x.executableToolDepends or [ ]); });

  packages = {
    default = justStaticExecutables package;
    inherit package;
  };
in
packages.default
