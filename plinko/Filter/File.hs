module File
  ( FileInfo
  , FileFilter
  , fd
  , path
  , size
  , mimeInfo
  , dataCreated
  ) where

  
  
-- probably use GIO or something along those lines ${1:String}
-- model the fileinfo types with whatever that turns out to be

  
sizeLess :: Integer -> FileFilter
sizeLess i = (i<) . FileInfo.size


