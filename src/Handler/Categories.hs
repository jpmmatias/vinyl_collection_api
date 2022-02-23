
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Categories where

import Import

getCategoriesR:: Handler Value
getCategoriesR= do
    categorie <- runDB $ selectList [] [] :: Handler [Entity Categorie]

    return $ object ["categorie" .= categorie]

postCategoriesR:: Handler ()
postCategoriesR= do
    categorie <- requireJsonBody :: Handler Categorie
    _    <- runDB $ insert categorie

    sendResponseStatus status201 ("CREATED" :: Text)
