{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/160b762eda6d139ac10ae081f8f78d640dd523eb";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  outputs = inputs: inputs.flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      inherit (pkgs) lib;
      eval = lib.evalModules {
        modules = [
          {
            options.bad = lib.mkOption {
              type = lib.types.nonEmptyListOf (lib.types.submodule { });
            };
            options.good = lib.mkOption {
              type = lib.types.nonEmptyListOf lib.types.str;
            };
          }
        ];
      };
    in
    {
      inherit (eval.options) bad good;

      
      # nix repl
      # nix-repl> :lf .

      /* Expected: "non-empty (list of (submodule))" */
      
      # nix-repl> bad.x86_64-linux.type.description
      # "list of (submodule)"
      
      /* Expected: "non-empty (list of string)" */

      # nix-repl> good.x86_64-linux.type.description
      # "non-empty (list of string)"
      
    }
  );
}
