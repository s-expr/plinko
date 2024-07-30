{-# LANGUAGE GADTs #-}
{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS_GHC -Wno-typed-holes #-}


module FileHandle
  ( Cache
  ) where 

import Data.Time (NominalDiffTime)
import System.IO
import System.Posix.Types
import Control.Lens
import Data.Maybe (fromMaybe)

type Date = NominalDiffTime
type FSize = Integer
type Count = Integer
type MimeType  = ()
type PermsType = FileMode
-- may need to break out cache implementation in to its
-- own file
newtype Cache =  Cache { _unCache :: CacheType }
type CacheLens a = Lens' Cache a

data CacheType = CacheType
  { _fileSize :: Maybe FSize
  , _fileMime ::  Maybe MimeType
  , _fileCount ::  Maybe Count
  , _dateCreated :: Maybe Date
  , _dateModified :: Maybe Date
  , _perms :: Maybe PermsType
  , _linkedPath :: Maybe FilePath
  }

getWithCached
  :: Cache
  -> Cache (Maybe a)
  -> IO a
  -> IO (Cache, a)
getWithCached _ field readval = do
  readval <- readval
  fmap (cache & field .~ return newval, newval)
  where
    curval = field ^. cache
    newval = return $ fromMaybe readval curval


