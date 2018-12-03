-- |
-- Module      : AOC2018.Challenge.Day03
-- Copyright   : (c) Justin Le 2018
-- License     : BSD3
--
-- Maintainer  : justin@jle.im
-- Stability   : experimental
-- Portability : non-portable
--
-- Day 3.  See "AOC2018.Solver" for the types used in this module!

module AOC2018.Challenge.Day03 (
    day03a
  , day03b
  ) where

import           AOC2018.Solver ((:~>)(..))
import           AOC2018.Util   (freqs, findMaybe)
import           Control.Monad  (guard)
import           Data.Char      (isDigit)
import           Data.Foldable  (toList)
import           Data.Ix        (range)
import           Data.Map       (Map)
import           Linear         (V2(..))
import qualified Data.Map       as M

-- | x and y
type Coord = V2 Int

-- | Start <x,y>, and size <w,h>
data Rect = R { _rStart :: Coord
              , _rSize  :: Coord
              }

-- | Attempt to parse a line into @(Int, Rect)@ (a claim ID #, and the
-- rectangle claimed)
parseLine :: String -> Maybe (Int, Rect)
parseLine = mkLine
          . map read
          . words
          . map onlyDigits
  where
    mkLine [i,x0,y0,w,h] = Just (i, R (V2 x0 y0) (V2 w h))
    mkLine _             = Nothing
    onlyDigits c
      | isDigit c = c
      | otherwise = ' '

-- | Get a list of all coordinates within a given rectangle specification
tiles :: Rect -> [Coord]
tiles (R start size) = range (start, start + size - 1)

-- | Generate a frequency map of tiles to number of claims at that tile
layTiles :: [Rect] -> Map Coord Int
layTiles = freqs . concatMap tiles

day03a :: [(Int, Rect)] :~> Int
day03a = MkSol
    { sParse = traverse parseLine . lines
    , sShow  = show
    , sSolve = Just
             . length               -- > how many?
             . filter (>= 2)        -- > only frequencies >= 2
             . toList               -- > get all frequencies
             . layTiles . map snd   -- > lay the tiles
    }

day03b :: _ :~> Int
day03b = MkSol
    { sParse = traverse parseLine . lines
    , sShow  = show
    , sSolve = \ts ->
        let tilesClaimed = layTiles (snd <$> ts)    -- > get all tiles claimed frequency map
        in  findMaybe (noOverlap tilesClaimed) ts   -- > find the ID that is not overlapping
    }

-- | Given a map of tiles claimed (and how many are claiming that spot) and
-- a claim ID and rectangle, check if all of the claim's rectangles are
-- alone in the map (are claimed by only one claim).
--
-- If yes, return the ID of the claim.
noOverlap
    :: Map Coord Int
    -> (Int, Rect)
    -> Maybe Int
noOverlap tilesClaimed (i, r) = i <$ guard (all isAlone (tiles r))
  where
    isAlone c = M.lookup c tilesClaimed == Just 1