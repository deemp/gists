{
  inputs = {
    nixpkgs-lib.url = "github:nixos/nixpkgs/b06ff4bf8f4ad900fe0c2a61fc2946edc3a84be7?dir=lib";
    nixpkgs.url = "github:nixos/nixpkgs/b06ff4bf8f4ad900fe0c2a61fc2946edc3a84be7";
    devshell = {
      url = "github:deemp/devshell/add-nested-commands";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs-lib";
    };
  };
  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      imports = [
        inputs.devshell.flakeModule
        ./module1.nix
        ./module2.nix
        ./module3.nix
      ];
    };

}
