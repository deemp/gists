{
  description = "PureScript app flake";
  inputs.flakes.url = "github:deemp/flakes";
  inputs.purescript-overlay.url = "github:thomashoneyman/purescript-overlay";

  inputs.purifix.url = "github:purifix/purifix";
  inputs.purifix.inputs.easy-purescript-nix.follows = "easy-purescript-nix";
  inputs.easy-purescript-nix.url = "github:justinwoo/easy-purescript-nix";

  outputs = inputs:
    let flakes = inputs.flakes; in
    flakes.makeFlake {
      inputs = {
        inherit (flakes.all) nixpkgs purescript-tools;
        inherit (inputs) purescript-overlay purifix;
      };
      perSystem = { inputs, system }:
        let
          pkgs = inputs.nixpkgs.legacyPackages.${system};
          pkgs-purescript = pkgs.extend inputs.purescript-overlay.overlays.default;

          inherit (pkgs-purescript) purs spago purs-tidy;
          inherit (pkgs) nodejs_18;
          inherit ((
            pkgs.extend
              (self: super: {
                purescript = purs;
                nodejs = nodejs_18;
              })).extend inputs.purifix.overlay) purifix;

          app = purifix {
            src = ./.;
          };
          devShells.default = pkgs.mkShell {
            buildInputs = [ app.develop ];
          };
        in
        {
          inherit devShells app;
        };
    };
}

