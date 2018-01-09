--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.List
import           Data.Monoid           ((<>))
import           Hakyll
import           System.FilePath.Posix


--------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do
  match "assets/images/*" $ do
    route   idRoute
    compile copyFileCompiler

  match "assets/images/**/*" $ do
    route   idRoute
    compile copyFileCompiler

  match "assets/css/*" $ do
    route   idRoute
    compile copyFileCompiler

  match "assets/js/*" $ do
    route   idRoute
    compile copyFileCompiler

  tags <- buildTags  "posts/**/*" $ fromCapture "tags/*"

  tagsRules tags $ \tag pattern -> do
    route cleanRoute
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
        >>= cleanIndexUrls


  match (fromList ["about.rst", "contact.markdown"]) $ do
    route cleanRoute
    compile $ pandocCompiler
      >>= loadAndApplyTemplate "templates/default.html" defaultContext
      >>= relativizeUrls
      >>= cleanIndexUrls


  match "posts/**/*" $ do
    route cleanRoute
    let ctx = tagsField "tags" tags <> postCtx

    compile $ pandocCompiler
      >>= loadAndApplyTemplate "templates/post.html" ctx
      >>= loadAndApplyTemplate "templates/default.html" ctx
      >>= relativizeUrls
      >>= cleanIndexUrls


  create ["posts.html"] $ do
    route cleanRoute
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
        >>= cleanIndexUrls


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
        >>= cleanIndexUrls

  match "templates/*" $ compile templateBodyCompiler


--------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
  dateField "date" "%b %d, %Y" <>
  defaultContext

cleanRoute :: Routes
cleanRoute = customRoute createIndexRoute
  where
    createIndexRoute ident = takeDirectory p </> takeBaseName p </> "index.html"
                            where p = toFilePath ident

cleanIndexUrls :: Item String -> Compiler (Item String)
cleanIndexUrls = return . fmap (withUrls cleanIndex)

cleanIndexHtmls :: Item String -> Compiler (Item String)
cleanIndexHtmls = return . fmap (replaceAll pattern replacement)
    where
      pattern = "/index.html"
      replacement = const "/"

cleanIndex :: String -> String
cleanIndex url
    | idx `isSuffixOf` url = take (length url - length idx) url
    | otherwise            = url
  where idx = "index.html"
