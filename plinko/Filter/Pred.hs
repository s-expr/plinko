{-# OPTIONS_GHC -Wno-typed-holes #-}
{-# LANGUAGE GADTs #-}

module Filter
  ( Prim2(..)
  , Pred(..)
  ) where

data Prim2 = And
           | Or
           | If
data Pred info = PTrue
               | PFalse 
               | PPredicate (info -> Bool)
               | PNot (Pred info)
               | PPrim2 Prim2 (Pred info) (Pred info)

predEval :: Pred info -> info -> Bool
predEval PTrue _ = True 
predEval PFalse _= False
predEval (PNot p1) info = not (predEval p1 info)
predEval (PPredicate f) info = f info
predEval (PPrim2 prim2 p1 p2) info = op  (pe p1)  (pe p2)
  where
     pe = flip predEval info
     op = case prim2 of
            And -> (&&)
            Or -> (||)
            If -> \a b -> b || not a
