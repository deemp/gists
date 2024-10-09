{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/master";
  outputs = inputs: {
    abra = inputs.nixpkgs.lib.evalModules {
      modules = [
        (
          { lib, ... }:
          {
            options = {
              # Overrides `description`
              # 
              # nix-repl> abra.options.bar.type.description
              # "submodule"
              # 
              foo = lib.mkOption rec {
                type =
                  let submodule = modules:
                    lib.types.submoduleWith {
                      shorthandOnlyDefinesConfig = true;
                      modules = lib.toList modules;
                      description = "description";
                    };
                  in
                  submodule { options = { }; };
                default = { };
              };

              # No overriding!!
              # 
              # nix-repl> abra.options.bar.type.description
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
              # nix-repl> abra.options.baz.type.description
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
