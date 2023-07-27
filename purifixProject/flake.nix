{
  description = "PureScript app flake";
  inputs.flakes.url = "github:deemp/flakes";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/ec322bf9e598a510995e7540f17af57ee0c8d5b9";
  inputs.purescript-overlay.url = "github:deemp/purescript-overlay";

  inputs.purifix.url = "github:purifix/purifix";
  inputs.purifix.inputs.easy-purescript-nix.follows = "easy-purescript-nix";

  inputs.easy-purescript-nix.url = "github:justinwoo/easy-purescript-nix";

  outputs = inputs:
    let flakes = inputs.flakes; in
    flakes.makeFlake {
      inputs = {
        inherit (flakes.all) nixpkgs purescript-tools devshell;
        inherit (inputs) purescript-overlay purifix;
      };
      perSystem = { inputs, system }:
        let
          inherit (inputs.devshell.lib.${system}) mkShell;

          pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [
              inputs.purescript-overlay.overlays.default
              (self: super: { purescript = self.purs-unstable; nodejs = super.nodejs_18; })
              inputs.purifix.overlay
            ];
          };

          app = pkgs.purifix { src = ./.; };

          devShells.default = mkShell {
            packagesFrom = [ app.develop ];
            packages = pkgs.lib.lists.imap0 pkgs.lib.setPrio [
              pkgs.purs-unstable
              pkgs.spago-unstable
              pkgs.purs-tidy-unstable
            ];
          };

          packages.default = app;
        in
        {
          inherit devShells packages;
        };
    };
}

