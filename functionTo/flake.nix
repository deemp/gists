{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  outputs = inputs:
    let
      inherit (inputs.nixpkgs) lib;
      # TODO constructed type
      result = lib.evalModules {
        modules = [
          ({ lib, config, ... }: {
            options = {
              foo = lib.mkOption {
                type = lib.types.attrsOf (
                  lib.types.either
                    lib.types.str
                    (
                      lib.types.functionTo
                        (lib.types.functionTo
                          (lib.types.listOf lib.types.str)
                        )
                    )
                );
                default = {
                  str = "str";
                  __functor = self: indices: map (x: self.${x}) indices;
                };
              };

              bar = lib.mkOption {
                type = lib.types.str;
                default = "";
              };
            };
            config = {
              bar = builtins.head (config.foo [ "str" ]);
            };
          })
        ];
      };
    in
    result
  ;
}
