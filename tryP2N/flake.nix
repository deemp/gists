{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    poetry2nix = {
      url = "github:nix-community/poetry2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  description = "A very basic flake";

  outputs = inputs:
    let system = "x86_64-linux"; in
    {
      devShells.${system}.default =
        let
          pkgs = inputs.nixpkgs.legacyPackages.${system};
          poetry2nix = inputs.poetry2nix.legacyPackages.${system};
          myAppEnv = poetry2nix.mkPoetryEnv {
            projectDir = ./.;
            editablePackageSources = {
              my-app = ./src;
            };
            python = pkgs.python310;
            overrides = poetry2nix.overrides.withDefaults (self: super:
              let
                # workaround https://github.com/nix-community/poetry2nix/issues/568
                addBuildInputs = name: buildInputs: super.${name}.overridePythonAttrs (old: {
                  buildInputs = (builtins.map (x: super.${x}) buildInputs) ++ (old.buildInputs or [ ]);
                });
                mkOverrides = pkgs.lib.attrsets.mapAttrs (name: value: addBuildInputs name value);
              in
              mkOverrides {
                jupyter-server-terminals = [ "hatchling" ];
                bs4 = [ "setuptools" ];
                jupyter-events = [ "hatchling" ];
                jupyter-server = [ "hatchling" ];
              }
            );
          };
        in
        myAppEnv.env.overrideAttrs (oldAttrs: {
          buildInputs = [ pkgs.hello ];
        });
    };
}
