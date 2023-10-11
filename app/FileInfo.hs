
module FileInfo (
  FileInfo(
      fd,
      path,
      size,
      mimeInfo,
      dateCreated)
  ) where

-- probably use GIO or something along those lines ${1:String}
-- model the fileinfo types with whatever that turns out to be

type FD = ()
  
data FileInfo = FileInfo{
  fd :: FD,
  path :: String,
  size :: Integer,
  mimeInfo :: (), -- placeholders
  dateCreated :: (),
  dateModified :: ()
}
