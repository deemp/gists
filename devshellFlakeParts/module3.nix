{ lib, config, ... }: {
  perSystem = { system, ... }: {
    devshells.default = {
      commands = [
        {
          help = "print baz";
          name = "baz";
          command = "echo baz";
        }
      ];
    };
  };
}
