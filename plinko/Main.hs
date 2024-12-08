module Main where

import Events.Event
main :: IO ()
main = do
  print "type in your name"
  name <- getLine
  print name
  print "bar"



