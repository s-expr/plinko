{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# OPTIONS_GHC -Wno-tped-holes #-}
{-# LANGUAGE GADTs #-}
module Filter
  (FileFilter)
where


-- ====Filters====
-- Size
-- Mimetype
-- Regex on name/path
-- Date Modified
-- Permissions
-- Owner
-- Filters are predicates on FileInfo and return true or false 

import FileInfo (FileInfo, size)

-- Option 1 --
type FileFilter = FileInfo -> Bool

(<&>) :: FileFilter -> FileFilter -> FileFilter
(<&>) f1 f2 fi = f1 fi && f2 fi

infixl 7 <&>

(<|>) :: FileFilter -> FileFilter -> FileFilter
(<|>) f1 f2 fi = f1 fi || f2 fi

infixr 7 <|>

sizeLess :: Integer -> FileFilter
sizeLess i fi= i <FileInfo.size fi


