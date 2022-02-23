{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}

module Handler.Artist where

import Import

getArtistR :: ArtistId -> Handler Value
getArtistR vid = do
  artist <- runDB $ get404 vid

  return $ object ["artist" .= (Entity vid artist)]

putArtistR:: ArtistId -> Handler Value
putArtistR vid  = do
    artist <- (requireJsonBody :: Handler Artist)

    runDB $ replace vid artist
    sendResponseStatus status200 ("UPDATED" :: Text)

deleteArtistR :: ArtistId -> Handler Value
deleteArtistR vid = do
    runDB $ delete vid

    sendResponseStatus status200 ("DELETED" :: Text)
