{
  description = "PureScript app flake";
  inputs.flakes.url = "github:deemp/flakes";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/ec322bf9e598a510995e7540f17af57ee0c8d5b9";
  inputs.purescript-overlay.url = "github:thomashoneyman/purescript-overlay";

  inputs.purifix.url = "github:purifix/purifix";
  inputs.purifix.inputs.easy-purescript-nix.follows = "easy-purescript-nix";
  inputs.easy-purescript-nix.url = "github:justinwoo/easy-purescript-nix";

  inputs.devshell.url = "github:numtide/devshell";
  inputs.devshell.inputs.nixpkgs.follows = "nixpkgs";

  outputs = inputs:
    let flakes = inputs.flakes; in
    flakes.makeFlake {
      inputs = {
        inherit (flakes.all) nixpkgs purescript-tools;
        inherit (inputs) purescript-overlay purifix devshell;
      };
      perSystem = { inputs, system }:
        let
          pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [
              inputs.devshell.overlays.default
              inputs.purescript-overlay.overlays.default
              (self: super: { purescript = self.purs-unstable; nodejs = super.nodejs_18; })
              inputs.purifix.overlay
            ];
          };
          inherit (pkgs) purifix;

          app = purifix { src = ./.; };
          devShells.default = app.develop;

          # produces an error
          devShells.devshell = pkgs.devshell.mkShell {
            packages = [
              pkgs.purs-unstable
              pkgs.spago-unstable
              pkgs.purs-tidy-unstable
            ];
          };
          packages = {
            default = app;
            purs = pkgs.purs-unstable;
            spago = pkgs.spago-unstable;
            purs-tidy = pkgs.purs-tidy-unstable;
          };
        in
        {
          inherit devShells packages;
        };
    };
}

