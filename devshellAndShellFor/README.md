# haskell-minimal

This is a minimal [flake](https://nixos.wiki/wiki/Flakes) for developing local `Haskell` packages.

It provides a [shellFor](https://nixos.wiki/wiki/Haskell#Using_shellFor_.28multiple_packages.29) as an input to [devshell](https://github.com/numtide/devshell).

If you'd like to run `shellFor` and `devshell` separately:

- don't use `packagesFrom` in [flake.nix](./flake.nix)
- run both devshells in [.envrc](./.envrc)

## This flake

The following tools are available in the default `devShell`:

- `cabal-install`
- `hpack`
- the `GHC` compiler
- the `Haskell Language Server`
- dependencies of local packages

## Composing devshells using direnv

`direnv` can run multiple devshells and `shellHooks`

```console
use flake
eval "$shellHook"
use flake .#another
eval "$shellHook"
```
