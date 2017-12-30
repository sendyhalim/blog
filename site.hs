--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid ((<>))
import           Hakyll


--------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do
  match "assets/images/**/*" $ do
    route   idRoute
    compile copyFileCompiler

  match "assets/css/*" $ do
    route   idRoute
    compile copyFileCompiler

  match "assets/js/*" $ do
    route   idRoute
    compile copyFileCompiler

  tags <- buildTags  "posts/**/*" $ fromCapture "tags/*.html"

  tagsRules tags $ \tag pattern -> do
    route idRoute
    compile $ do
      posts <- recentFirst =<< loadAll pattern
      let title = "Posts tagged with " ++ tag
      let ctx =
            constField "title" title <>
            constField "tag" tag <>
            listField "posts" postCtx (return posts) <>
            defaultContext

      makeItem ""
        >>= loadAndApplyTemplate "templates/posts-by-tag.html" ctx
        >>= loadAndApplyTemplate "templates/default.html" ctx
        >>= relativizeUrls

  match (fromList ["about.rst", "contact.markdown"]) $ do
    route   $ setExtension "html"
    compile $ pandocCompiler
      >>= loadAndApplyTemplate "templates/default.html" defaultContext
      >>= relativizeUrls

  match "posts/**/*" $ do
    route $ setExtension "html"
    let ctx = tagsField "tags" tags <> postCtx

    compile $ pandocCompiler
      >>= loadAndApplyTemplate "templates/post.html" ctx
      >>= loadAndApplyTemplate "templates/default.html" ctx
      >>= relativizeUrls

  create ["posts.html"] $ do
    route idRoute
    compile $ do
      posts <- recentFirst =<< loadAll "posts/**/*"
      let postsCtx =
            listField "posts" postCtx (return posts) <>
            constField "title" "Posts" <>
            defaultContext

      makeItem ""
        >>= loadAndApplyTemplate "templates/posts.html" postsCtx
        >>= loadAndApplyTemplate "templates/default.html" postsCtx
        >>= relativizeUrls


  match "index.html" $ do
    route idRoute
    compile $ do
      posts <- recentFirst =<< loadAll "posts/**/*"
      let indexCtx =
            listField "posts" postCtx (return posts) <>
            constField "title" "Sendy Halim" <>
            defaultContext

      getResourceBody
        >>= applyAsTemplate indexCtx
        >>= loadAndApplyTemplate "templates/default.html" indexCtx
        >>= relativizeUrls

  match "templates/*" $ compile templateBodyCompiler


--------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
  dateField "date" "%B %e, %Y" <>
  defaultContext
