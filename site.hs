--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Char
import           Data.Monoid (mappend)
import           Data.List ()
import qualified Data.Map ()
import           Hakyll
import           Hakyll.Web.Tags ()
import qualified System.FilePath.Posix as F

--------------------------------------------------------------------------------
baseUrl :: String
baseUrl = "sukeesh.tech"

myFeedConfiguration :: FeedConfiguration
myFeedConfiguration = FeedConfiguration
    { feedTitle       = "Sukeesh"
    , feedDescription = "Senior Undergraduate at IIT Roorkee"
    , feedAuthorName  = "Sukeesh"
    , feedAuthorEmail = "vsukeeshbabu@gmail.com"
    , feedRoot        = "http://sukeesh.tech"
    }

main :: IO ()
main = hakyll $ do


       match "assets/js/**" $ do
             route assetsRoute
             compile copyFileCompiler

       match "assets/css/**" $ do
             route assetsRoute
             compile compressCssCompiler

       match "assets/images/**" $ do
             route assetsRoute
             compile copyFileCompiler

       match "assets/fonts/**" $ do
             route assetsRoute
             compile copyFileCompiler

       match (fromList ["404.md", "CNAME", "favicon.ico"]) $ do
             route idRoute
             compile copyFileCompiler

       match "projects/**" $ do
         route projectRoute
         compile copyFileCompiler

       match "resume.pdf" $ do
         route idRoute
         compile copyFileCompiler

       tags <- buildTags "posts/**" (fromCapture "tags/*.html")
       cats <- buildCategoriesNew "posts/**" (fromCapture "categories/*.html")

       let posts = recentFirst =<< loadAll ("posts/**" .&&. hasNoVersion)
       let postCtx = dateField "date" "%B %e, %Y" `mappend`
             tagsField "tags" tags `mappend`
             tagsField "cats" cats `mappend`
             dateField "dateMap" "%Y-%m-%d" `mappend`
             defaultContext
       let ctxWithPosts title =
             constField "title" title `mappend`
             listField "posts" postCtx posts `mappend`
             postCtx

       -- | Add Tags
       tagsRules tags $ \tag pat -> do
           route $ cleanRoute False
           let title = "Posts with tag \"" ++ tag ++ "\""
           compile $ do
             lessPosts <- recentFirst =<< loadAll pat
             let ctx = constField "title" title `mappend`
                       listField "posts" postCtx (return lessPosts) `mappend`
                       defaultContext
             makeItem ""
               >>= loadAndApplyTemplate "templates/archive.html" ctx
               >>= loadAndApplyTemplate "templates/with-title.html"   ctx
               >>= loadAndApplyTemplate "templates/with-sidebar.html" ctx
               >>= loadAndApplyTemplate "templates/default.html" ctx
               >>= relativizeUrls
               >>= cleanIndexHtmls

       -- | Add Categories
       tagsRules cats $ \tag pat -> do
           route $ cleanRoute False
           let title = "Posts in category \"" ++ tag ++ "\""
           compile $ do
             lessPosts <- recentFirst =<< loadAll pat
             let ctx = constField "title" title `mappend`
                       listField "posts" postCtx (return lessPosts) `mappend`
                       defaultContext
             makeItem ""
               >>= loadAndApplyTemplate "templates/archive.html" ctx
               >>= loadAndApplyTemplate "templates/with-title.html"   ctx
               >>= loadAndApplyTemplate "templates/with-sidebar.html" ctx
               >>= loadAndApplyTemplate "templates/default.html" ctx
               >>= relativizeUrls
               >>= cleanIndexHtmls

       match "posts/**" $ do
             route $ postRoute
             compile $ do
               pandocCompiler
                     >>= loadAndApplyTemplate "templates/post.html"         postCtx
                     >>= saveSnapshot "content"
                     >>= loadAndApplyTemplate "templates/with-tags.html"    postCtx
                     >>= loadAndApplyTemplate "templates/with-title.html"   postCtx
                     >>= loadAndApplyTemplate "templates/with-sidebar.html" postCtx
                     >>= loadAndApplyTemplate "templates/default.html"      postCtx
                     >>= relativizeUrls

       match "posts/**" $ version "source" $ do
             route $ setExtension "html"
             let redirectCtx =
                   functionField "newUrl" (\x _ -> return $ modernPostPath (x !! 0)) `mappend` postCtx
             compile $ do
               pandocCompiler
                     >>= loadAndApplyTemplate "templates/redirect.html" redirectCtx

       match "templates/**" $ compile templateBodyCompiler

       create ["index.html"] $ do
         route idRoute
         let ctx = ctxWithPosts "DO IT!" `mappend`
                   constField "imageUrl" "/images/green.jpg"
         compile $ do
           makeItem ""
             >>= loadAndApplyTemplate "templates/index.html"        ctx
             >>= loadAndApplyTemplate "templates/with-image.html"   ctx
             >>= loadAndApplyTemplate "templates/with-title.html"   ctx
             >>= loadAndApplyTemplate "templates/with-sidebar.html" ctx
             >>= loadAndApplyTemplate "templates/default.html"      ctx
             >>= relativizeUrls
             >>= cleanIndexHtmls

       create ["archives.html"] $ do
         route $ cleanRoute True
         let ctx = ctxWithPosts "Archive"
         compile $ do
           makeItem ""
             >>= loadAndApplyTemplate "templates/archive.html"      ctx
             >>= loadAndApplyTemplate "templates/with-title.html"   ctx
             >>= loadAndApplyTemplate "templates/with-sidebar.html" ctx
             >>= loadAndApplyTemplate "templates/default.html"      ctx
             >>= relativizeUrls

       create ["categories.html"] $ do
         route $ cleanRoute True
         let ctx = ctxWithPosts "Categories" `mappend`
                   field "tagList" (\_ -> renderTagCloud 100 170 cats)
         compile $ do
           makeItem ""
             >>= loadAndApplyTemplate "templates/tags.html"         ctx
             >>= loadAndApplyTemplate "templates/with-title.html"   ctx
             >>= loadAndApplyTemplate "templates/with-sidebar.html" ctx
             >>= loadAndApplyTemplate "templates/default.html"      ctx
             >>= relativizeUrls

       create ["tags.html"] $ do
         route $ cleanRoute True
         let ctx = ctxWithPosts "Tags" `mappend`
                   field "tagList" (\_ -> renderTagCloud 100 170 tags)
         compile $ do
           makeItem ""
             >>= loadAndApplyTemplate "templates/tags.html"         ctx
             >>= loadAndApplyTemplate "templates/with-title.html"   ctx
             >>= loadAndApplyTemplate "templates/with-sidebar.html" ctx
             >>= loadAndApplyTemplate "templates/default.html"      ctx
             >>= relativizeUrls

       match (fromList ["about.md"])$ do
         route $ cleanRoute True
         let ctx = ctxWithPosts "About"
         compile $ do
           pandocCompiler
             >>= loadAndApplyTemplate "templates/with-title.html"   ctx
             >>= loadAndApplyTemplate "templates/with-sidebar.html" ctx
             >>= loadAndApplyTemplate "templates/default.html"      ctx
             >>= relativizeUrls

       create ["sitemap.xml"] $ do
              route   idRoute
              let ctx = constField "baseUrl" baseUrl `mappend`
                        ctxWithPosts "SiteMap"
              compile $ do
                makeItem ""
                 >>= loadAndApplyTemplate "templates/sitemap.xml" ctx
                 >>= cleanIndexHtmls

       create ["rss.xml"] $ do
           route idRoute
           compile $ do
               let feedCtx = postCtx `mappend` bodyField "description"
               pPosts <- fmap (take 10) . recentFirst =<<
                   loadAllSnapshots ("posts/**" .&&. hasNoVersion) "content"
               renderRss myFeedConfiguration feedCtx pPosts

       create ["atom.xml"] $ do
           route idRoute
           compile $ do
               let feedCtx = postCtx `mappend` bodyField "description"
               pPosts <- fmap (take 10) . recentFirst =<<
                   loadAllSnapshots ("posts/**" .&&. hasNoVersion) "content"
               renderAtom myFeedConfiguration feedCtx pPosts

--------------------------------------------------------------------------------
cleanIndexHtmls :: Item String -> Compiler (Item String)
cleanIndexHtmls = return . fmap (replaceAll pattern replacement)
    where
      pattern = "/index.html"

replacement :: String -> String
replacement = const "/"

modernPostPath :: String -> String
modernPostPath path =
  year ++ "/" ++ month ++ "/" ++ rest
  where
    fileName = F.takeBaseName path
    year = takeWhile (/= '-') $ fileName
    month = takeWhile (/= '-') . drop 1 . dropWhile (/= '-') $ fileName
    rest = dropWhile (\x -> isDigit x || x == '-') $ fileName

postRoute :: Routes
postRoute = (customRoute $ (\path -> modernPostPath $ toFilePath path))
  `composeRoutes` cleanRoute False

cleanRoute :: Bool -> Routes
cleanRoute isTopLevel =
  customRoute $
  (++ "/index.html") . takeWhile (/= '.') . (adjustPath isTopLevel) . toFilePath
  where
    adjustPath False = id
    adjustPath True = reverse . takeWhile (/= '/') . reverse

assetsRoute :: Routes
assetsRoute = customRoute $ (\x -> x :: String) . drop 7 . toFilePath

-- | Add support for adding category directly to the metadata
-- | Helps avoid changing paths of posts while migrating from old blog
getCustomCat :: MonadMetadata m => Identifier -> m [String]
getCustomCat identifier = do
    metadata <- getMetadataField identifier "category"
    return $ maybe [] (map trim . splitAll ",") metadata

buildCategoriesNew :: MonadMetadata m => Pattern -> (String -> Identifier) -> m Tags
buildCategoriesNew = buildTagsWith getCustomCat

projectRoute :: Routes
projectRoute =
  idRoute `composeRoutes`
  (customRoute $ (++ "/index") . takeWhile (/= '.') . drop 9 . toFilePath ) `composeRoutes`
  setExtension "html"
