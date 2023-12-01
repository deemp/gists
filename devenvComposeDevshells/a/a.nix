{ ... }: {
  perSystem = { welcome, ... }: {
    devenv.shells.a = {
      env.SHELL_NAME = "a";
      enterShell = welcome;
    };
  };
}
