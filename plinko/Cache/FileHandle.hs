{-# LANGUAGE GADTs #-}

{-
File "handles" with cacheable file info.
Minimizes disk reads when applying
filters to files.
-}

module FileHandle
  ( FileInfoCache
  , FileHandle
  ) where 

import Cache (Cache)


data Filetype
  = File
  | Folder
  | Symlink

data FileHandle = FileHandle 
  { path :: FilePath
  , typ :: Filetype
  , _cache :: Cache
  }

_readDateModified :: FileHandle -> IO ()
_readDateModified = 

getDateModified :: FileHandle -> IO (FileHandle, Date)
getDateModified fh = undefined
