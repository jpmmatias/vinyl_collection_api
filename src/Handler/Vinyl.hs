{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Vinyl where

import Import

putVinylR:: VinylId -> Handler Value
putVinylR vid  = do
    vinyl <- (requireJsonBody :: Handler Vinyl)

    runDB $ replace vid vinyl
    sendResponseStatus status200 ("UPDATED" :: Text)

getVinylR :: VinylId -> Handler Value
getVinylR vid = do
    post <- runDB $ get404 vid

    return $ object ["vinyl" .= (Entity vid post)]

deleteVinylR :: VinylId -> Handler Value
deleteVinylR vid = do
    runDB $ delete vid

    sendResponseStatus status200 ("DELETED" :: Text)

