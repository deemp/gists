{
  inputs = {
    flakes.url = "github:deemp/flakes";
  };
  outputs = inputs: inputs.flakes.makeFlake {
    inputs = { inherit (inputs.flakes.all) nixpkgs nix-filter slimlock devshell; };
    perSystem = { inputs, system }:
      let
        pkgs = inputs.nixpkgs.legacyPackages.${system};
        inherit (inputs) nix-filter;
        inherit (pkgs.lib.strings) concatStringsSep splitString;
        inherit (pkgs.lib.lists) init;
        inherit (inputs.devshell.lib.${system}) mkShell;

        packages.default =
          let
            inherit (pkgs.appendOverlays [ inputs.slimlock.overlays.default ]) slimlock;
            packageLock = (slimlock.buildPackageLock { src = ./.; }).overrideAttrs (final: prev: {
              nativeBuildInputs = prev.nativeBuildInputs or [ ] ++ [
                pkgs.nodePackages.node-pre-gyp
                pkgs.python3
                pkgs.pkg-config
                pkgs.poppler_utils
                pkgs.pangomm
                pkgs.jq
              ];
              buildPhase = ''
                ${concatStringsSep "\n" (init (init (splitString "\n" prev.buildPhase)))}

                rm ./node_modules/.bin/node-pre-gyp

                PACKAGES="$(\
                  cat package-lock.json \
                    | jq -r '.packages 
                      | keys_unsorted 
                      | .[] 
                      | select(length > 0 and . != "node_modules/@mapbox/node-pre-gyp") 
                      | "./" + .'\
                )"

                npm rebuild --offline "$PACKAGES"
              '';
            });
          in
          packageLock;

        devShells.default = mkShell {
          commands = [{ package = pkgs.nodejs_20; }];
        };
      in
      {
        inherit packages devShells;
      };
  };
}
