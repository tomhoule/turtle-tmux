{-# LANGUAGE OverloadedStrings #-}

module Main where

import Prelude hiding (FilePath)
import Data.Maybe
import Turtle

main :: IO ()
main = sh theThing

fpToTxt :: FilePath -> Text
fpToTxt path = format (fp) $ path

theThing :: Shell ()
theThing = do
    path <- home >>= \h -> return $ h <> "src"
    dirs <- ls path
    bin <- which "tmux" >>= return . fromJust
    let dir = fpToTxt dirs
    inproc (format (fp) $ bin) ["new", "-d", "-c", dir, "-s", last $ cut (text "/") dir] empty
    exit ExitSuccess
