{ lib, config, ... }: {
  perSystem = { system, ... }: {
    devshells.default = {
      commands.scripts = [
        {
          help = "print foo";
          name = "foo";
          command = "echo foo";
        }
      ];
    };
  };
}
