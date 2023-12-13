{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/2bbf67d3c76927b5c3148f32c0e93c14e5dbc2d9";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = inputs: inputs.flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = inputs.nixpkgs.legacyPackages.${system};

      packages = {
        helloApp = (pkgs.writeShellApplication {
          name = "hello";
          text = ''printf "hello!\n"'';
        })
        .overrideAttrs (prev: {
          buildCommand = null;
          passAsFile = [];
          phases = [ "installPhase" "checkPhase" ];
          installPhase = ''
            runHook preInstall

            target=$out${pkgs.lib.escapeShellArg "/bin/${prev.name}"}

            mkdir -p "$(dirname "$target")"

            if [ -e "$textPath" ]; then
              mv "$textPath" "$target"
            else
              echo -n "$text" > "$target"
            fi

            if [ -n "$executable" ]; then
              chmod +x "$target"
            fi

            runHook postInstall
          '';
        })
        ;

        hello = pkgs.hello.overrideAttrs (prev: {
          postPhases = [ "postInstall" ];
          postInstall = ''
            does fail
          '';
        });
      };
    in
    {
      inherit packages;
    });
}
