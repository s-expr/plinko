{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# OPTIONS_GHC -Wno-tped-holes #-}
{-# LANGUAGE GADTs #-}

module Filter
  ( Filter
  , constTrue
  , constFalse
  , apply
  , (<&&>)
  , (<||>)
  , fnot
  ) where

import Control.Monad (liftM2)

newtype Filter info = Filter (info -> IO Bool)

constTrue :: Filter a 
constTrue = Filter $ const (return True)

constFalse :: Filter a
constFalse = Filter $ const (return False)

apply :: Filter info -> info -> IO Bool
apply (Filter f) = f

join
  :: (Bool -> Bool -> Bool)
  -> Filter info
  -> Filter info
  -> Filter info
join op f1 f2 =
  Filter $ \info -> liftM2 op (apply f1 info) (apply f2 info)

(<&&>) :: Filter info -> Filter info -> Filter info
(<&&>) = join (&&)
  
(<||>) :: Filter info -> Filter info -> Filter info
(<||>) = join (||)

-- conditional
fcond :: Filter info -> Filter info -> Filter info
fcond f1 f2 = fnot f1 <||> f2

fnot :: Filter info -> Filter info
fnot = join (const not) constTrue
