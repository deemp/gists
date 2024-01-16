{ lib, config, ... }: {
  perSystem = { system, ... }: {
    devshells.default = {
      commands.scripts = [
        {
          help = "print bar";
          name = "bar";
          command = "echo bar";
        }
      ];
    };
  };
}
