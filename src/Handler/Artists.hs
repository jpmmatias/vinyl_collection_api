
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Artists where

import Import

getArtistsR :: Handler Value
getArtistsR = do
    artist <- runDB $ selectList [] [] :: Handler [Entity Artist]

    return $ object ["artist" .= artist]

postArtistsR:: Handler ()
postArtistsR= do
    artist <- requireJsonBody :: Handler Artist
    _    <- runDB $ insert artist

    sendResponseStatus status201 ("CREATED" :: Text)
