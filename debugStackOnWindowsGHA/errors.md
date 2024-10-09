# Scenarios

## Scenario 1

1. Connect to a Windows runner via tmate.

1. Wait until cache is restored.

1. Run commands:

```console
runneradmin@fv-az1258-298 MINGW64 /d/a/normalizer/normalizer
# cmd
Microsoft Windows [Version 10.0.20348.2402]
(c) Microsoft Corporation. All rights reserved.

D:\a\normalizer\normalizer>rm -rf eo-phi-normalizer/src/Language/EO/Phi/Syntax

D:\a\normalizer\normalizer>stack build
eo-phi-normalizer-0.3.1: unregistering (local file changes:
C:\Users\runneradmin\AppData\Local\Programs\stack\x86_64-windows\ghc-9.6.4\lib\x86_64-windows-ghc...)
eo-phi-normalizer> configure (lib + exe)
eo-phi-normalizer> [1 of 3] Compiling Main             ( D:\a\normalizer\normalizer\eo-phi-normalizer\Setup.hs, D:\a\normalizer\normalizer\eo-phi-normalizer\.stack-work\dist\ab060f89\setup\Main.o ) [Source file changed]
eo-phi-normalizer> [3 of 3] Linking D:\a\normalizer\normalizer\eo-phi-normalizer\.stack-work\dist\ab060f89\setup\setup.exe [Objects changed]
eo-phi-normalizer> Configuring eo-phi-normalizer-0.3.1...
eo-phi-normalizer> Active code page: 65001
eo-phi-normalizer> build (lib + exe) with ghc-9.6.4
eo-phi-normalizer> Preprocessing library for eo-phi-normalizer-0.3.1..
eo-phi-normalizer> Building library for eo-phi-normalizer-0.3.1..
eo-phi-normalizer> 
eo-phi-normalizer> <no location info>: warning: [GHC-32850] [-Wmissing-home-modules]
eo-phi-normalizer>     These modules are needed for compilation but not listed in your .cabal file's other-modules for `eo-phi-normalizer-0.3.1-K95HcCWlixTEfLIOzDdndy' :
eo-phi-normalizer>         Language.EO.Phi.Syntax.Lex Language.EO.Phi.Syntax.Par
eo-phi-normalizer> [ 1 of 16] Compiling Language.EO.Phi.Syntax.Lex
eo-phi-normalizer> [ 2 of 16] Compiling Language.EO.Phi.Syntax.Par
eo-phi-normalizer> 
eo-phi-normalizer> .stack-work\dist\ab060f89\build\Language\EO\Phi\Syntax\Par.hs:26:1: error:
eo-phi-normalizer> [10 of 16] Compiling Language.EO.Phi.TH
eo-phi-normalizer>     Could not find module `Language.EO.Phi.Syntax.Abs'
eo-phi-normalizer>     Use -v (or `:set -v` in ghci) to see a list of the files searched for.
eo-phi-normalizer>    |
eo-phi-normalizer> 26 | import qualified Language.EO.Phi.Syntax.Abs
eo-phi-normalizer>    | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
eo-phi-normalizer> [16 of 16] Compiling Paths_eo_phi_normalizer

Error: [S-7282]
    Stack failed to execute the build plan.

    While executing the build plan, Stack encountered the error:
    
    [S-7011]
    While building package eo-phi-normalizer-0.3.1 (scroll up to its section
    to see the error) using:
    D:\a\normalizer\normalizer\eo-phi-normalizer\.stack-work\dist\ab060f89\setup\setup --verbose=1 --builddir=.stack-work\dist\ab060f89 build lib:eo-phi-normalizer exe:normalizer --ghc-options " -fdiagnostics-color=always"
```

## Scenario 2

```console
D:\a\normalizer\normalizer>stack build --force-dirty
transform-eo-tests> configure (exe)
transform-eo-tests> Configuring transform-eo-tests-0.1.0.0...
transform-eo-tests> build (exe) with ghc-9.6.4
transform-eo-tests> Preprocessing executable 'transform-eo-tests' for transform-eo-tests-0.1.0.0..
transform-eo-tests> Building executable 'transform-eo-tests' for transform-eo-tests-0.1.0.0..
eo-phi-normalizer > build (lib + exe) with ghc-9.6.4
transform-eo-tests> copy/register
transform-eo-tests> Installing executable transform-eo-tests in D:\a\normalizer\normalizer\.stack-work\install\5611b766\bin
eo-phi-normalizer > Preprocessing library for eo-phi-normalizer-0.3.1..
eo-phi-normalizer > Building library for eo-phi-normalizer-0.3.1..
eo-phi-normalizer >            
eo-phi-normalizer > <no location info>: warning: [GHC-32850] [-Wmissing-home-modules]
eo-phi-normalizer >     These modules are needed for compilation but not listed in your .cabal file's other-modules for `eo-phi-normalizer-0.3.1-K95HcCWlixTEfLIOzDdndy' :
eo-phi-normalizer >         Language.EO.Phi.Syntax.Lex Language.EO.Phi.Syntax.Par
eo-phi-normalizer > [ 2 of 16] Compiling Language.EO.Phi.Syntax.Par
eo-phi-normalizer >            
eo-phi-normalizer > .stack-work\dist\ab060f89\build\Language\EO\Phi\Syntax\Par.hs:26:1: error:
eo-phi-normalizer >     Could not find module `Language.EO.Phi.Syntax.Abs'
eo-phi-normalizer >     Use -v (or `:set -v` in ghci) to see a list of the files searched for.
eo-phi-normalizer >    |
eo-phi-normalizer > 26 | import qualified Language.EO.Phi.Syntax.Abs
eo-phi-normalizer >    | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Completed 2 action(s).         

Error: [S-7282]
    Stack failed to execute the build plan.

    While executing the build plan, Stack encountered the error:

    [S-7011]
    While building package eo-phi-normalizer-0.3.1 (scroll up to its section to see the error) using:
    D:\a\normalizer\normalizer\eo-phi-normalizer\.stack-work\dist\ab060f89\setup\setup --verbose=1 --builddir=.stack-work\dist\ab060f89 build lib:eo-phi-normalizer exe:normalizer --ghc-options " -fdiagnostics-color=always"
    Process exited with code: ExitFailure 1
```

## Scenario 3

```console
D:\a\normalizer\normalizer>rm -rf .stack-work

D:\a\normalizer\normalizer>stack build
eo-phi-normalizer > configure (lib + exe)
transform-eo-tests> configure (exe)
transform-eo-tests> Configuring transform-eo-tests-0.1.0.0...
eo-phi-normalizer > Configuring eo-phi-normalizer-0.3.1...
transform-eo-tests> build (exe) with ghc-9.6.4
transform-eo-tests> Preprocessing executable 'transform-eo-tests' for transform-eo-tests-0.1.0.0..
transform-eo-tests> Building executable 'transform-eo-tests' for transform-eo-tests-0.1.0.0..
transform-eo-tests> copy/register
eo-phi-normalizer > Active code page: 65001
transform-eo-tests> Installing executable transform-eo-tests in D:\a\normalizer\normalizer\.stack-work\install\5611b766\bin
eo-phi-normalizer > build (lib + exe) with ghc-9.6.4
eo-phi-normalizer > Preprocessing library for eo-phi-normalizer-0.3.1..
eo-phi-normalizer > Building library for eo-phi-normalizer-0.3.1..
eo-phi-normalizer >            
eo-phi-normalizer > <no location info>: warning: [GHC-32850] [-Wmissing-home-modules]
eo-phi-normalizer >     These modules are needed for compilation but not listed in your .cabal file's other-modules for `eo-phi-normalizer-0.3.1-K95HcCWlixTEfLIOzDdndy' :
eo-phi-normalizer >         Language.EO.Phi.Syntax.Lex Language.EO.Phi.Syntax.Par
eo-phi-normalizer > [ 2 of 16] Compiling Language.EO.Phi.Syntax.Par
eo-phi-normalizer >            
eo-phi-normalizer > .stack-work\dist\ab060f89\build\Language\EO\Phi\Syntax\Par.hs:26:1: error:
eo-phi-normalizer >     Could not find module `Language.EO.Phi.Syntax.Abs'
eo-phi-normalizer >     Use -v (or `:set -v` in ghci) to see a list of the files searched for.
eo-phi-normalizer >    |
eo-phi-normalizer > 26 | import qualified Language.EO.Phi.Syntax.Abs
eo-phi-normalizer >    | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Completed 2 action(s).         

Error: [S-7282]
       Stack failed to execute the build plan.

       While executing the build plan, Stack encountered the error:

       [S-7011]
       While building package eo-phi-normalizer-0.3.1 (scroll up to its section to see the error) using:
       D:\a\normalizer\normalizer\eo-phi-normalizer\.stack-work\dist\ab060f89\setup\setup --verbose=1 --builddir=.stack-work\dist\ab060f89 build lib:eo-phi-normalizer exe:normalizer --ghc-options " -fdiagnostics-color=always"
       Process exited with code: ExitFailure 1
```

## Scenario 4

Edit `eo-phi-normalizer/Setup.hs`.

```hs
{-# LANGUAGE CPP #-}
{-# LANGUAGE QuasiQuotes #-}

-- Source: https://github.com/haskell/cabal/issues/6726#issuecomment-918663262

-- | Custom Setup that runs bnfc to generate the language sub-libraries
-- for the parsers included in Ogma.
module Main (main) where

import Distribution.Simple (defaultMainWithHooks, hookedPrograms, postConf, preBuild, simpleUserHooks)
import Distribution.Simple.Program (Program (..), findProgramVersion, simpleProgram)
import PyF (fmt)
import System.Process (system)

-- | Run BNFC, happy, and alex on the grammar before the actual build step.
--
-- All options for bnfc are hard-coded here.
main :: IO ()
main =
  defaultMainWithHooks $
    simpleUserHooks
      { hookedPrograms = [bnfcProgram]
      , postConf = \args flags packageDesc localBuildInfo -> do
          _ <-
            system $
              [fmt|
                chcp 65001 ^
                    && bnfc --haskell -d -p Language.EO.Phi --generic -o src/ grammar/EO/Phi/Syntax.cf ^
                    && cd src/Language/EO/Phi/Syntax ^
                    && alex Lex.x ^
                    && happy Par.y
              |]
          postConf simpleUserHooks args flags packageDesc localBuildInfo
      }

-- | NOTE: This should be in Cabal.Distribution.Simple.Program.Builtin.
bnfcProgram :: Program
bnfcProgram =
  (simpleProgram "bnfc")
    { programFindVersion = findProgramVersion "--version" id
    }
```

```console
D:\a\normalizer\normalizer>rm -rf eo-phi-normalizer/src/Language/EO/Phi/Syntax

D:\a\normalizer\normalizer>stack build --reconfigure
eo-phi-normalizer> configure (lib + exe)
eo-phi-normalizer> [1 of 3] Compiling Main             ( D:\a\normalizer\normalizer\eo-phi-normalizer\Setup.hs, D:\a\normalizer\normalizer\eo-phi-normalizer\.stack-work\dist\ab060f89\setup\Main.o ) [Source file changed]
eo-phi-normalizer> [3 of 3] Linking D:\a\normalizer\normalizer\eo-phi-normalizer\.stack-work\dist\ab060f89\setup\setup.exe [Objects changed]
eo-phi-normalizer> Configuring eo-phi-normalizer-0.3.1...
eo-phi-normalizer> build (lib + exe) with ghc-9.6.4
eo-phi-normalizer> Preprocessing library for eo-phi-normalizer-0.3.1..
eo-phi-normalizer> Building library for eo-phi-normalizer-0.3.1..
eo-phi-normalizer> 
eo-phi-normalizer> <no location info>: warning: [GHC-32850] [-Wmissing-home-modules]
eo-phi-normalizer>     These modules are needed for compilation but not listed in your .cabal file's other-modules for `eo-phi-normalizer-0.3.1-K95HcCWlixTEfLIOzDdndy' :
eo-phi-normalizer>         Language.EO.Phi.Syntax.Lex Language.EO.Phi.Syntax.Par
eo-phi-normalizer> [ 2 of 16] Compiling Language.EO.Phi.Syntax.Par [Language.EO.Phi.Syntax.Abs changed]
eo-phi-normalizer> 
eo-phi-normalizer> .stack-work\dist\ab060f89\build\Language\EO\Phi\Syntax\Par.hs:26:1: error:
eo-phi-normalizer>     Could not find module `Language.EO.Phi.Syntax.Abs'
eo-phi-normalizer>     Use -v (or `:set -v` in ghci) to see a list of the files searched for.
eo-phi-normalizer>    |
eo-phi-normalizer> 26 | import qualified Language.EO.Phi.Syntax.Abs
eo-phi-normalizer>    | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Error: [S-7282]
       Stack failed to execute the build plan.

       While executing the build plan, Stack encountered the error:

       [S-7011]
       While building package eo-phi-normalizer-0.3.1 (scroll up to its section to see the error) using:
       D:\a\normalizer\normalizer\eo-phi-normalizer\.stack-work\dist\ab060f89\setup\setup --verbose=1 --builddir=.stack-work\dist\ab060f89 build lib:eo-phi-normalizer exe:normalizer --ghc-options " -fdiagnostics-color=always"
       Process exited with code: ExitFailure 1
```
