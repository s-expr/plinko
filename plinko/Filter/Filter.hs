{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# OPTIONS_GHC -Wno-tped-holes #-}
{-# LANGUAGE GADTs #-}
module Filter
  (Filter)
where

import 
-- ====Filters====
-- Size
-- Mimetype
-- Regex on name/path
-- Date Modified
-- Permissions
-- Owner
-- Filters are predicates on FileInfo and return true or false 


-- Option 1 --

class (f :: a -> Bool) => Filter f where

  (<&>) :: f -> f -> f
  (<&>) f1 f2 fi = f1 ap fi && f2 fi
  
  (<|>) :: f -> f -> f
  (<|>) f1 f2 fi = f1 fi || f2 fi

infixl 7 <&>
infixr 7 <|>

