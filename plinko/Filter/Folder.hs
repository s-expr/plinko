module Folder (
  FolderHandle
) where

type FD = ()
type Date = ()


--cacheable information for Folders
data FolderHandle = FolderHandle {
  fd :: FD,
  dateCreated :: Maybe Date,
  dateModified :: Maybe Date
}

getDateCreated :: FolderHandle -> IO Date
getDateCreated fh =
  case dateCreated fh of
    Just d -> return d
    Nothing ->
      undefined




