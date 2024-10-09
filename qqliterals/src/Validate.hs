{-# LANGUAGE TemplateHaskellQuotes #-}
{-# LANGUAGE TypeApplications #-}

module Validate (word6) where

import QQLiterals (QuasiQuoter, qqLiteral)

word6Either :: [Char] -> Either String Integer
word6Either s =
    let s' = read @Integer s
     in if s' >= 0 && s' < 64
            then Right s'
            else Left "Literal must belong to the range 0..63"

word6 :: QuasiQuoter
word6 = qqLiteral word6Either 'word6Either
