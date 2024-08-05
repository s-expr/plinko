{-# LANGUAGE GADTs #-}
{-# OPTIONS_GHC -Wno-typed-holes #-}
{-
File info cache for all watched files
-}

module Cache.Cache
  ( Cache
  ) where 

import Cache.CacheEntry
  ( CacheEntry
  , CacheEntryLens
  )
import Control.Monad.ST
import qualified Data.HashTable.ST.Cuckoo as C
import qualified Data.HashTable.Class as H


type Path = String
newtype Cache s = Cache { 
  unCache :: C.HashTable s Path CacheEntry
}
type CacheCtx s = ST s Cahce s
-- types wrapped in ST are STILL PURE
-- Just design the interface of the cache within the ST monad

makeCache :: ST s (C.HashTable s Path CacheEntry)
makeCache = C.new

update :: Path -> CacheEntryLens a -> Cache s -> ST s Cache s
update path = _

insert :: Path -> CacheEntryLens a -> a -> ST s ()
insert = 
