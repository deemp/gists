# Scenarios

## 1

```console
rm -rf eo-phi-normalizer/src/Language/EO/Phi/Syntax
stack build
```

```console
D:\a\normalizer\normalizer>stack build       
eo-phi-normalizer> build (lib + exe) with ghc-9.6.4
eo-phi-normalizer> Preprocessing library for eo-phi-normalizer-0.3.1..
eo-phi-normalizer> Building library for eo-phi-normalizer-0.3.1..
eo-phi-normalizer> [ 1 of 14] Compiling Language.EO.Phi.Rules.Common
eo-phi-normalizer> 
eo-phi-normalizer> src\Language\EO\Phi\Rules\Common.hs:19:1: error:
eo-phi-normalizer>     Could not find module `Language.EO.Phi.Syntax.Abs'
eo-phi-normalizer>     Use -v (or `:set -v` in ghci) to see a list of the files searched for.
eo-phi-normalizer>    |
eo-phi-normalizer> 19 | import Language.EO.Phi.Syntax.Abs
eo-phi-normalizer>    | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
eo-phi-normalizer>
eo-phi-normalizer> src\Language\EO\Phi\Rules\Common.hs:20:1: error:
eo-phi-normalizer>     Could not find module `Language.EO.Phi.Syntax.Lex'
eo-phi-normalizer>     Use -v (or `:set -v` in ghci) to see a list of the files searched for.
eo-phi-normalizer>    |
eo-phi-normalizer> 20 | import Language.EO.Phi.Syntax.Lex (Token)
eo-phi-normalizer>    | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
eo-phi-normalizer>
eo-phi-normalizer> src\Language\EO\Phi\Rules\Common.hs:21:1: error:
eo-phi-normalizer>     Could not find module `Language.EO.Phi.Syntax.Par'
eo-phi-normalizer>     Use -v (or `:set -v` in ghci) to see a list of the files searched for.
eo-phi-normalizer>    |
eo-phi-normalizer> 21 | import Language.EO.Phi.Syntax.Par
eo-phi-normalizer>    | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Error: [S-7282]
    Stack failed to execute the build plan.

    While executing the build plan, Stack encountered the error:

    [S-7011]
    While building package eo-phi-normalizer-0.3.1 (scroll up to its section to see the error) using:
    D:\a\normalizer\normalizer\eo-phi-normalizer\.stack-work\dist\ab060f89\setup\setup --verbose=1 --builddir=.stack-work\dist\ab060f89 build lib:eo-phi-normalizer exe:normalizer --ghc-options " -fdiagnostics-color=always"
    Process exited with code: ExitFailure 1
```
