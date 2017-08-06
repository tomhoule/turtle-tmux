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
    tmux <- which "tmux" >>= return . fpToTxt . fromJust
    let dir = fpToTxt dirs
    let sessionName = last $ cut (text "/") dir
    inproc tmux ["new", "-d", "-c", dir, "-s", sessionName] empty
    exit ExitSuccess
