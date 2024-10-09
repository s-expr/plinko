{-# LANGUAGE GADTs, RankNTypes #-}
{-# LANGUAGE TemplateHaskell #-}

{-
Cached file info.
Minimizes disk reads when checking
files info against predicates.
-}

module Cache.CacheEntry
  ( FileInfo
  , Field
  , FileType
  , size
  , mime
  , count
  , created
  , perms
  , makeCE
  , setCE
  , getCE
  ) where 

import Data.Time (NominalDiffTime)
import System.IO
import System.Posix.Types
import Control.Lens.TH (makeLenses)
import Control.Lens ( Lens', set, view)
import Data.Maybe (fromMaybe)

type Date = NominalDiffTime
type FSize = Integer
type Count = Integer
type MimeType  = ()
type PermsType = FileMode


data FileType = File | Folder
  deriving (Show)

data FileInfo = FileInfo
  { _typ :: FileType
  , _size :: Maybe FSize
  , _mime ::  Maybe MimeType
  , _count ::  Maybe Count
  , _created :: Maybe Date
  , _modified :: Maybe Date
  , _perms :: Maybe PermsType
  } deriving (Show)

type Field a = Lens' FileInfo a
makeLenses ''FileInfo

makeCE :: FileType -> FileInfo
makeCE ft = FileInfo
  { _typ = ft
  , _size = Nothing
  , _mime = Nothing
  , _count = Nothing
  , _created = Nothing
  , _modified = Nothing
  , _perms = Nothing  
  }

setCE :: Field a -> a -> FileInfo -> FileInfo
setCE lens = set 

getCE :: Field a -> FileInfo -> a
getCE lens = view 

