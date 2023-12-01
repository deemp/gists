{ ... }: {
  perSystem = { config, welcome, ... }: {
    devenv.shells.b = {
      env.SHELL_NAME = "b";
      enterShell = welcome;
    };
  };
}
