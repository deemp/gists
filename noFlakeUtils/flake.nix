{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    systems = {
      flake = false;
      url = "path:nix-systems.nix";
    };
  };

  outputs = inputs: (perSystem:
    inputs.nixpkgs.lib.pipe (import inputs.systems) [
      (builtins.map (system: builtins.mapAttrs (_: value: { ${system} = value; }) (perSystem system)))
      (builtins.foldl' inputs.nixpkgs.lib.recursiveUpdate { })
    ])
    (system:
      let
        pkgs = inputs.nixpkgs.legacyPackages.${system};
        packages.hello = pkgs.hello;
      in
      {
        inherit packages;
      }
    );
}
