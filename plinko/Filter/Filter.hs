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

newtype Filter info = Filter (info -> Bool)

constTrue :: Filter a 
constTrue = Filter $ const True

constFalse :: Filter a
constFalse = Filter $ const False

apply :: Filter info -> info -> Bool
apply (Filter f) = f

join
  :: (Bool -> Bool -> Bool)
  -> Filter info
  -> Filter info
  -> Filter info
join op f1 f2 =
  Filter $ \info -> op (apply f1 info) (apply f2 info)

(<&&>) :: Filter info -> Filter info -> Filter info
(<&&>) = join (&&)
  
(<||>) :: Filter info -> Filter info -> Filter info
(<||>) = join (||)

fnot :: Filter info -> Filter info
fnot = join (const not) constTrue
