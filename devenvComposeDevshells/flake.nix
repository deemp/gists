{
  description = "A very basic flake";
  inputs = {
    # <frameworks>
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # <devtools>
    devenv.url = "github:cachix/devenv";
    flake-root.url = "github:srid/flake-root";

    nix2container.url = "github:nlewo/nix2container"; # https://github.com/cachix/devenv/issues/528

  };

  outputs = inputs:
    with builtins; let
      lib = inputs.nixpkgs.lib;
    in
    with lib;
    inputs.flake-parts.lib.mkFlake { inherit inputs; }
      {
        imports = with inputs; [
          flake-root.flakeModule
          devenv.flakeModule
          ./a/a.nix
          ./b/b.nix
        ];
        systems = [ "x86_64-linux" ];
        perSystem =
          { config
          , self'
          , system
          , inputs'
          , ...
          }:
          let
            pkgs = import inputs.nixpkgs {
              inherit system;
              config.allowUnfree = true;
            };
            welcome = ''
              echo "=========$SHELL_NAME=========="
              FLAKE_ROOT=$(${lib.getExe config.flake-root.package})
              cd "$FLAKE_ROOT/$SHELL_NAME" # This is very important
              echo "$SHELL_NAME> FLAKE_ROOT is $FLAKE_ROOT"
              echo "$SHELL_NAME> PWD is $PWD. pwd is: $(pwd). Nix files: $(ls | grep ".nix")"
              echo ">>>>>>>>>>>$SHELL_NAME<<<<<<<<<"
            '';
          in
          {
            _module.args = { inherit lib pkgs welcome; };
          }
          // (optionalAttrs (!inPureEvalMode) {
            devShells.default = pkgs.mkShell {
              inputsFrom = [
                config.flake-root.devShell
                self'.devShells.main
                self'.devShells.a
                self'.devShells.b
              ];
            };
            devenv.shells.main = {
              env.SHELL_NAME = "main";
              enterShell = welcome;
            };
          });
      };
}

