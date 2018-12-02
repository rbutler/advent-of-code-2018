-- |
-- Module      : AOC2018.Challenge.Day02
-- Copyright   : (c) Justin Le 2018
-- License     : BSD3
--
-- Maintainer  : justin@jle.im
-- Stability   : experimental
-- Portability : non-portable
--
-- Day 2.  See "AOC2018.Challenge" for the types used in this module!

module AOC2018.Challenge.Day02 (
    day02a
  , day02b
  ) where

import           AOC2018.Prelude
import qualified Data.Map        as M
import qualified Data.Set        as S

-- | We compute a frequency map of all of the characters in a string, and
-- then get all of the frequencies that happened for each line.
--
-- Then we build a frequency map of the frequencies!
day02a :: [String] :~> Int
day02a = MkSol
    { sParse = Just . lines
    , sShow  = show
    , sSolve = mulTwoThree
             . freqs
             . concatMap (nubOrd . M.elems . freqs)
    }
  where
    mulTwoThree m = (*) <$> (2 `M.lookup` m) <*> (3 `M.lookup` m)

-- | The main work is in 'firstNeighbor', which looks thorugh a list of
-- items and finds the first item whose neighbor was already seen.
--
-- Then we take the two "almost matching" strings and filter out all of the
-- characters that aren't the same, using 'zipWith' and 'catMaybes'.
day02b :: [String] :~> String
day02b = MkSol
    { sParse = Just . lines
    , sShow  = id
    , sSolve = fmap (uncurry onlySame)
             . firstNeighbor
    }
  where
    onlySame xs = catMaybes . zipWith (\x y -> x <$ guard (x == y)) xs

-- | Find the first string in a list that is a neighbor of a previous
-- string.
firstNeighbor :: [String] -> Maybe (String, String)
firstNeighbor = go S.empty
  where
    go seen (x:xs) = case find (`S.member` seen) (neighbors x) of
        Just n  -> Just (x, n)
        Nothing -> go (x `S.insert` seen) xs
    go _ [] = Nothing

-- | Get all one-character neighbors of a given string
neighbors :: String -> [String]
neighbors = perturbations (const ['a'..'z'])