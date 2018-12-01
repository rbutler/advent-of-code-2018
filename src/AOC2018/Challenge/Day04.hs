{-# OPTIONS_GHC -Wno-unused-imports   #-}
{-# OPTIONS_GHC -Wno-unused-top-binds #-}

-- |
-- Module      : AOC2018.Challenge.Day04
-- Copyright   : (c) Justin Le 2018
-- License     : BSD3
--
-- Maintainer  : justin@jle.im
-- Stability   : experimental
-- Portability : non-portable
--
-- Day 4.  See "AOC2018.Challenge" for the types used in this module!
--
-- After completing the challenge, it is recommended to:
--
-- *   Replace "AOC2018.Prelude" imports to specific modules (with explicit
--     imports) for readability.
-- *   Remove the @-Wno-unused-imports@ and @-Wno-unused-top-binds@
--     pragmas.
-- *   Replace the partial type signatures underscores in the solution
--     types @_ :~> _@ with the actual types of inputs and outputs of the
--     solution.  You can delete the type signatures completely and GHC
--     will recommend what should go in place of the underscores.

module AOC2018.Challenge.Day04 (
    -- day04a
  -- , day04b
  ) where

import           AOC2018.Prelude

day04a :: _ :~> _
day04a = MkSol
    { sParse = Just
    , sShow  = id
    , sSolve = Just
    }

day04b :: _ :~> _
day04b = MkSol
    { sParse = Just
    , sShow  = id
    , sSolve = Just
    }
