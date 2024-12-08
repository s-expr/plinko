{-# LANGUAGE RankNTypes, ImpredicativeTypes, GADTs#-}
{-# OPTIONS_GHC -Wno-typed-holes #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Redundant bracket" #-}


--Cute Event loop

module Events.Event where
import System.FSNotify 
import Data.Functor.Identity
import Debug.Trace
import Data.Map

type Path = String
type EventID = String

data Event m ret where
  Log :: String -> Event IO ()
  FSNotify :: Path -> FSNotify.Event.Eevent  -> Event m () 
  --UserDefined :: EventID -> info -> Event m (Maybe ret)
  None :: ret -> Event m ret

instance Functor m => Functor (Event m) where
  fmap = fmap

instance Applicative m => Applicative (Event m) where
  pure = None
  (<*>) :: Applicative m => Event m (a -> b) -> Event m a -> Event m b
  (<*>) = (<*>)
  
instance Monad m => Monad (Event m) where
  return :: Monad m => a -> Event m a
  return = pure
  (>>=) = (>>=)

runEvent :: (Monad m) => Event m a -> m a 
runEvent (Log msg) = print msg
runEvent (FileSystem _ _) = _
runEvent (None a) = return a

foo :: a -> Event IO a
foo = return 

{-
listSum :: Num n => State [n] n
listSum = do
  nums <- get
  case nums of
    n : ns -> do
      put ns
      (+n) <$> listSum
    [] -> return 0
-}




