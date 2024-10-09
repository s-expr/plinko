{-# LANGUAGE GADTs, RankNTypes #-}
{-# OPTIONS_GHC -Wno-typed-holes #-}
{-
File info cache for all watched files
-}

module Cache.Cache
  ( Cache
  ) where 

import Cache.CacheEntry
  ( FileInfo
  , Field
  )
import Control.Monad.ST
import qualified Data.HashTable.ST.Cuckoo as C
import qualified Data.HashTable.Class as H

type Path = String

newtype Cache s a = Cache { 
  ref :: C.HashTable s Path a
}

type FileInfoCache = forall s. Cache s FileInfo

type Cached s = StateT s Cache s 
-- types wrapped in ST are STILL PURE
-- Just design the interface of the cache within the ST monad

makeCache :: ST s (C.HashTable s Path FileInfo)
makeCache = C.new

update :: Path -> (a -> a) -> Cache s -> ST s Cache s
update path = _

insert :: Path -> a -> Cache s a 
insert = _
