{-# LANGUAGE GADTs #-}

{-
File "handles" with cacheable file info.
Minimizes disk reads when applying
filters to files.
-}

module CacheEntry
  ( FileInfoCache
  , FileHandle
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



data Filetype
  = File
  | Folder
  | Symlink

data FileHandle = FileHandle 
  { path :: FilePath
  , typ :: Filetype
  , _cache :: Cache
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


--_readDateModified :: FileHandle -> IO ()
--_readDateModified = 

--getDateModified :: FileHandle -> IO (FileHandle, Date)
--getDateModified fh = undefined
