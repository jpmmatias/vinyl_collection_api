
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Vinies where

import Import

getViniesR:: Handler Value
getViniesR= do
    vinyl <- runDB $ selectList [] [] :: Handler [Entity Vinyl]

    return $ object ["vinyl" .= vinyl]

postViniesR :: Handler ()
postViniesR = do
    vinyl <- requireJsonBody :: Handler Vinyl
    _    <- runDB $ insert vinyl

    sendResponseStatus status201 ("CREATED" :: Text)



