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
  package = pkgs.haskellPackages.callCabal2nix pname src.outPath { };
  packages = {
    default = pkgs.haskell.lib.justStaticExecutables package;
    inherit package;
  };
in
packages.default
