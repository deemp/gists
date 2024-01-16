{
  inputs = {
    devshell.url = "github:deemp/devshell/add-nested-commands";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
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
