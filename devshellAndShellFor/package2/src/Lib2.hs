module Lib2 (someFunc) where

import qualified Lib1

someFunc :: IO ()
someFunc = Lib1.someFunc
