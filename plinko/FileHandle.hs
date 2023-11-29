{-# LANGUAGE GADTs #-}

{-
File "handles" with cachable file info.
Minimizes disk reads when applying
filters to files.
-}

module FileHandle
  ( FileInfoCache
  , FileHandle
  ) where 

import Data.Time (NominalDiffTime)
import System.IO
import System.Posix.Types

type Date = NominalDiffTime
type FSize = Integer
type Count = Integer
type MimeType  = ()
type PermsType = FileMode
newtype Cache =  Cache { _unCache :: FileInfoCache }

data Filetype
  = File
  | Folder
  | Symlink

data FileHandle = FileHandle 
  { path :: FilePath
  , typ :: Filetype
  , _cache :: Cache
  }

data FileInfoCache = FileInfoCache
  { fileSize :: Maybe FSize
  , fileMime ::  Maybe MimeType
  , fileCount ::  Maybe Count
  , dateCreated :: Maybe Date
  , dateModified :: Maybe Date
  , perms :: Maybe PermsType
  , linkedPath :: Maybe FilePath
  }


_getWithCache
  :: FileHandle
  -> (fh -> IO meta)
  -> (FileInfoCache -> Maybe meta)
  -> IO (FileHandle, meta)
_getWithCache fh reader selector = 
  let props = _unCache . _cache $ fh in
  case selector props of
    Just meta -> return (fh, meta)
    Nothing ->
      reader fh >>= 
      (,) $ fh { _cache = Cache { _unCache = props} }

_readDateModified :: FileHandle -> IO ()
_readDateModified = undefined

getDateModified :: FileHandle -> IO (FileHandle, Date)
getDateModified fh =
  case dateModified _fh of
    Just date -> date
    Nothing -> undefined
