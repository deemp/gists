{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/master";
  outputs = inputs: {
    foo = inputs.nixpkgs.lib.evalModules {
      modules = [
        (
          { lib, ... }:
          {
            options = {
              # No overriding!!
              # 
              # nix-repl> foo.options.bar.type.description
              # "submodule"
              # 
              bar = lib.mkOption {
                type =
                  (lib.types.submodule { options = { }; })
                  //
                  {
                    description = "description";
                    name = "name";
                  };
                default = { };
              };

              # Overrides OK
              # 
              # nix-repl> foo.options.baz.type.description
              # "description"
              # 
              baz = lib.mkOption {
                type =
                  lib.types.anything
                  //
                  {
                    description = "description";
                    name = "name";
                  };
                default = { };
              };
            };
          }
        )
      ];
    };
  };
}
