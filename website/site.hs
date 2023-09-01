{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TupleSections #-}
{-# LANGUAGE FlexibleContexts #-}
import           Data.Monoid (mappend)
import           Hakyll
import           Text.Pandoc.Options
import qualified Text.Regex as RE 
import Text.Pandoc.Definition
import Text.Pandoc.Walk
import Data.Maybe
import Data.Char
import Data.List
import qualified Data.Text as T
import qualified Data.ByteString.Lazy as B (ByteString)
import qualified Data.ByteString.Lazy.UTF8 as BU 
import Data.Time
import Debug.Trace
import Control.Applicative
import Hakyll.Core.Compiler.Internal
import Hakyll.Core.Metadata
import Control.Monad
import Data.Ord (comparing)
import Text.Read
import qualified Data.Set                       as S
import qualified GHC.IO.Encoding as E

import Data.Time.Format (parseTime)
import Data.Time.Clock (UTCTime)


--------------------------------------------------------------------------------
myConfig = defaultConfiguration {
  deployCommand = "echo DEPLOYING; rsync -r _site/* $HOME/mth406/ && cd $HOME/mth406 && echo copying to mth406 && git add . && git commit && git push"
  }

  
main :: IO ()
main = do
  -- E.setLocaleEncoding E.utf8
  hakyllWith myConfig $ do
    match "images/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "**/images/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match "files/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "**pdfs/**" $ do
        route   idRoute
        compile copyFileCompiler


----------image slide show



------------------announcements

    match "announcements/*" $ do
        route $ setExtension "html"
        compile $ do
            ctx <- allPostsCtx
            pandocMathCompiler
              >>= loadAndApplyTemplate "templates/announcement.html"    (postCtx `mappend` localModifiedTime)
              >>= saveSnapshot "content"
              >>= relativizeUrls



------------------posts

    match "posts/*" $ version "titleline" $ do
        route $ setExtension "html"
        compile $ 
            pandocMathCompiler

    match "posts/*.md" $ do
        route $ setExtension "html"
        compile $ do
            ctx <- allPostsCtx
            pandocMathCompiler
              >>= saveSnapshot "teasercontent"
              >>= loadAndApplyTemplate "templates/post.html"  (prevNextCtx ("posts/*.md"  .&&. hasNoVersion)  `mappend` postCtx) --  postCtx
              >>= saveSnapshot "content"
              >>= loadAndApplyTemplate "templates/default.html" (postCtx `mappend` ctx)
              >>= relativizeUrls



    match "posts/*.md" $ version "pdfs" $ do
        route $ postPdfRoute
        compile $ do
          --pandocMathCompiler
          getResourceLBS >>= withItemBody (unixFilterLBS "pandoc" ["--resource-path=./posts","-o", "/home/shane/stdout.pdf"])






    create ["posts.html"] $ do
        route idRoute
        compile $ do
            posts <- chronological =<< loadAll ("posts/*" .&&. hasNoVersion)
            let archiveCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    constField "title" "Comments"            `mappend`
                    defaultContext
            ctx <- allPostsCtx

            makeItem ""
                >>= loadAndApplyTemplate "templates/posts.html" archiveCtx
                >>= loadAndApplyTemplate "templates/default.html" ctx
                >>= relativizeUrls



---------------Solutions
    match "*/solutions/*.tex" $ version "titleline" $ do
        route $ setExtension "html"
        compile $ 
            pandocMathCompiler

    match "*/solutions/*.tex" $ version "solutionpdfs" $ do
        route $ solutionPdfRoute
        compile $ do
          getResourceString
              >>= loadAndApplyTemplate "templates/solutionpreamble.tex" assignmentCtx
              >>= withItemBody (unixFilterLBS "rubber-pipe" ["-d", "--into", "./assignments/solutions"] . stringToByte)

    match "*/solutions/*.md" $ version "solutionpdfs" $ do
        route $ solutionPdfRoute
        compile $ do
          getResourceLBS >>= withItemBody (unixFilterLBS "pandoc" ["--resource-path=./assignments/solutions","-o", "/home/shane/stdout.pdf"])


    match "*/solutions/*.tex" $ do
        route $ setExtension "html"
        compile $ do
            ctx <- allPostsCtx
            pandocMathCompiler
              >>= loadAndApplyTemplate "templates/solution.html" solutionCtx
              >>= saveSnapshot "soln"
              >>= saveSnapshot "content"
              >>= loadAndApplyTemplate "templates/default.html" (ctx `mappend` solutionCtx)
              >>= relativizeUrls

{-
    create ["solutions.html"] $ do
        route idRoute
        compile $ do
            solutions <- fmap sortAssignments $ loadAll ("solutions/*"  .&&. hasNoVersion)
            let archiveCtx =
                    listField "solutions" assignmentCtx (return $ solutions) `mappend`
                    defaultContext
            ctx <- allPostsCtx

            makeItem ""
                >>= loadAndApplyTemplate "templates/solutions.html" archiveCtx
                >>= loadAndApplyTemplate "templates/default.html" ctx
                >>= relativizeUrls
-}

--------------texslides

    match "texslides/*.pdf" $ do
        route idRoute
        compile $ do
          -- makeItem is needed to save a snapshot that has text
          -- so that it will be of type Compiler String rather than
          -- Compiler Copyfile
          makeItem ("" :: String) >>= saveSnapshot "rawslide"
          copyFileCompiler

    match "texslides/*.tex" $ do
        route $ assignmentPdfRoute
        compile $ do
          getResourceString
            >>= saveSnapshot "rawslide"
            >>= withItemBody (unixFilterLBS "/home/shane/.local/bin/presentation-exe" ["-"] . BU.fromString)
            >>= withItemBody  (return . BU.toString)
            >>= loadAndApplyTemplate "templates/slidepreamble.tex" slideCtx'
            >>= withItemBody (unixFilterLBS "rubber-pipe" ["-d"] . stringToByte)


    create ["slides.html"] $ do
        route idRoute
        compile $ do
            slides <- chronological =<< loadAllSnapshots "texslides/*" "rawslide"
            let archiveCtx =
                    listField "slides" slideCtx' (return $ slides) `mappend`
                    defaultContext
            ctx <- allPostsCtx 

            makeItem ""
                >>= loadAndApplyTemplate "templates/slides.html" archiveCtx
                >>= loadAndApplyTemplate "templates/default.html" (ctx `mappend` archiveCtx)
                >>= relativizeUrls


    match "imageslides/*/*.svg" $ version "images" $ do
        route idRoute
        compile copyFileCompiler
          

    match "imageslides/*/*.svg" $ do
        route $ setExtension "html" 
        compile $ do
          ctx <- allPostsCtx 
          fmap (itemSetBody "") copyFileCompiler
            >>= loadAndApplyTemplate "templates/imageslide.html" (prevNextCtx ("imageslides/*/*.svg"  .&&. hasNoVersion) `mappend` pathField "url")
            >>= loadAndApplyTemplate "templates/default.html" ctx
          


--------------assignments

    match "assignments/*.tex" $ version "pdfs" $ do
        route $ assignmentPdfRoute
        compile $ do
          getResourceString
              >>= loadAndApplyTemplate "templates/preamble.tex" assignmentCtx
              -- >>= withItemBody (return . stringToByte)
              >>= withItemBody (unixFilterLBS "rubber-pipe" ["-d"] . stringToByte)
          --getResourceLBS >>= withItemBody addLatexPreamble >>= withItemBody (unixFilterLBS "rubber-pipe" ["-d"])
          --getResourceLBS >>= withItemBody (unixFilterLBS "pandoc" ["-o", "/home/shane/stdout.pdf"])

    match "assignments/*.md" $ version "pdfs" $ do
        route $ assignmentPdfRoute
        compile $ do
          getResourceLBS >>= withItemBody (unixFilterLBS "pandoc" ["-o", "/home/shane/stdout.pdf"])

    match "assignments/*" $ version "titleline" $ do
        route $ setExtension "html"
        compile $ 
            pandocMathCompiler


    match "assignments/*.tex" $ do
        route $ setExtension "html"
        compile $ do
            forceDep
            ctx <- allPostsCtx
            pandocMathCompiler
              >>= loadAndApplyTemplate "templates/assignment.html" (prevNextCtx ("assignments/*.tex"  .&&. hasNoVersion)  `mappend` assignmentCtx)
              >>= saveSnapshot "content"
              >>= loadAndApplyTemplate "templates/default.html" (ctx `mappend` assignmentCtx)
              >>= relativizeUrls


    create ["assignments.html"] $ do
        route idRoute
        compile $ do
            assignments <- fmap sortAssignments $ loadAll ("assignments/*"  .&&. hasNoVersion)
            --solutions <- fmap sortAssignments $ loadAll ("*/solutions/*"  .&&. hasVersion "titleline")
            let archiveCtx =
                    listField "assignments" assignmentCtx (return $ assignments) `mappend`
             --       listField "solutions" solutionCtx (return $ solutions) `mappend`
                    defaultContext
            ctx <- allPostsCtx 

            makeItem ""
                >>= loadAndApplyTemplate "templates/assignments.html" archiveCtx
                >>= loadAndApplyTemplate "templates/default.html" ctx
                >>= relativizeUrls


----------------Slides

{-
    match "slides/*.tex" $ version "pdfs" $ do
        route $ setExtension "pdf"
        compile $ do
          getResourceLBS
            l>= withItemBody (unixFilterLBS "/home/shane/.local/bin/presentation-exe" ["-"])
            >>= withItemBody  (return . BU.toString)
            >>= loadAndApplyTemplate "templates/slidepreamble.tex" slideCtx'
            >>= withItemBody (unixFilterLBS "rubber-pipe" ["-d"] . stringToByte)



    match "slides/*.pdf" $ do
        route idRoute
        compile copyFileCompiler

    create ["slides.html"] $ do
        route idRoute
        compile $ do
            posts <- chronological =<< loadAll "slides/*.pdf"
            let archiveCtx =
                    listField "slides" slideCtx (return posts) `mappend`
                    defaultContext
            ctx <- allPostsCtx

            makeItem ""
                >>= loadAndApplyTemplate "templates/slides.html" archiveCtx
                >>= loadAndApplyTemplate "templates/default.html" ctx

                >>= relativizeUrls
-}
{-
--- TESTING 
    match "slides/*.tex" $ do
        route $ setExtension "pdf"
        compile $ do
          getResourceString
              >>= loadAndApplyTemplate "templates/preamble.tex" assignmentCtx
              -- >>= withItemBody (return . stringToByte)
              >>= withItemBody (unixFilterLBS "rubber-pipe" ["-d"] . stringToByte)
 -}

    match "index.markdown" $ do
        route $ setExtension "html"
        compile $ do
            fullCtx <- allPostsCtx
            announcements <- recentlyModifiedFirst =<< loadAll ("announcements/*" .&&. hasNoVersion)
            let announcementsCtx =
                  case announcements of
                    [] -> mempty
                    _ -> 
                        listField "announcements" postCtx (return $ take 4 announcements) `mappend`
                        constField "title" "Announcements"            `mappend`
                        defaultContext
            pandocMathCompiler
                >>= loadAndApplyTemplate "templates/announcement-list.html" (defaultContext `mappend` announcementsCtx)
                >>= loadAndApplyTemplate "templates/default.html" fullCtx
                >>= relativizeUrls

    match "templates/*" $ compile templateBodyCompiler
{-
    create ["atom.xml"] $ do
        route idRoute
        compile $ do
            let feedCtx = exerciseTitleCtx `mappend` assignmentCtx `mappend` bodyField "description" `mappend` updatedTime `mappend` exerciseTitleCtx
            posts <- sortAssignments <$>
                loadAllSnapshots ("assignments/*.tex" .&&. hasNoVersion) "content"
            renderAtom myFeedConfiguration feedCtx (take 10 posts)
-}

    create ["atom.xml"] $ do
        route idRoute
        compile $ do
            (feedCtx, posts) <- feeds
            renderAtom myFeedConfiguration feedCtx posts


    create ["rss.xml"] $ do
        route idRoute
        compile $ do
            (feedCtx, posts) <- feeds
            renderRss myFeedConfiguration feedCtx posts


  
    create ["announce/atom.xml"] $ do
        route idRoute
        compile $ do
            let feedCtx = assignmentCtx `mappend` bodyField "description" `mappend` updatedTime
            posts <- recentlyModifiedFirst =<<
                loadAllSnapshots ("announcements/*" .&&. hasNoVersion) "content"
            renderAtom myFeedConfiguration feedCtx (take 10 posts)

    create ["announce/rss.xml"] $ do
        route idRoute
        compile $ do
            let feedCtx = assignmentCtx `mappend` bodyField "description" `mappend` updatedTime
            posts <- recentlyModifiedFirst =<<
                loadAllSnapshots ("announcements/*" .&&. hasNoVersion) "content"
            renderRss myFeedConfiguration feedCtx (take 10 posts)
--------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
    teaserField "teaser" "teasercontent" `mappend`
    commentTitleContext `mappend`
    dateField "date" "%e %B, %Y (%A)" `mappend`
    --pdfCtx `mappend`
    --defaultContext
    pdfCtx `mappend`
    strippedfileCtx `mappend`
    localModifiedTime `mappend`
    pdfCtx `mappend`
    defaultContext


slideCtx :: Context CopyFile
slideCtx =
    dateField "date" "%e %B, %Y (%A)" `mappend`
    urlField "url"


slideCtx' :: Context String
slideCtx' =
    teaserField "teaser" "teasercontent" `mappend`
    dateField "date" "%e %B, %Y (%A)" `mappend`
    urlField "url" `mappend`
    localModifiedTime `mappend`
    defaultContext


allPostsCtx = do
    forceDeps 
    posts <- recentFirst =<< loadAll ("posts/*" .&&. hasVersion "titleline")
    let indexCtx =
          case posts of
            [] -> mempty
            _ -> listField "posts" postCtx (return $ take 3 posts) `mappend` defaultContext

    assignments <- fmap sortAssignments $ loadAll ("assignments/*" .&&. hasVersion "titleline")
    let assignmentsCtx =
            listField "assignments" assignmentCtx (return $ take 2 $ reverse assignments) `mappend` 
            defaultContext

{-
    solutions <- fmap sortAssignments $ loadAll ("*/solutions/*" .&&. hasVersion "titleline")
    let solutionsCtx =
            listField "solutions" solutionCtx (return $ take 1 $ reverse solutions) `mappend` 
            defaultContext
-}
    
    slides <- recentFirst =<< loadAllSnapshots "texslides/*" "rawslide"
    let slidesCtx =
            listField "slides" slideCtx' (return $ take 2 slides)

    return (indexCtx `mappend` slidesCtx `mappend` assignmentsCtx)
--    return (indexCtx  `mappend` assignmentsCtx)
  




-------------------------------------------------------------------------------

pandocMathCompiler :: Compiler (Item String)
pandocMathCompiler = pandocCompilerWithTransformM defaultHakyllReaderOptions pandocOptions internalTransform

pandocMathCompilerForPdfImages d = pandocCompilerWithTransformM defaultHakyllReaderOptions pandocOptions (internalTransform . pandocAddLinkDirFilter d)

-- | https://groups.google.com/forum/#!msg/hakyll/XbB20ak441q/1bzn-d_2WugJ
internalTransform :: Pandoc -> Compiler Pandoc 
internalTransform = return




pandocOptions :: WriterOptions
pandocOptions = defaultHakyllWriterOptions{ writerHTMLMathMethod = MathJax "" }


--------------------------------------
--For PDF

assignmentCtx :: Context String
assignmentCtx =
    --solutionCtx `mappend`
    teaserField "teaser" "teasercontent" `mappend`
    pdfCtx `mappend`
    strippedfileCtx `mappend`
    localModifiedTime `mappend`
    solutionUrlCtx `mappend`
    pdfCtx `mappend`
    solutionPdfUrlCtx `mappend`
    defaultContext


solutionCtx :: Context String
solutionCtx =
    --solutionUrlCtx `mappend`
    teaserField "teaser" "teasercontent" `mappend`
    pdfCtx `mappend`
    --solutionPdfUrlCtx `mappend`
    strippedfileCtx `mappend`
    localModifiedTime `mappend`
    defaultContext

solutionUrlCtx' = field "solutionurl" $ \item -> do
   return $ addSolutionsFolder $ toFilePath $ itemIdentifier item

solutionUrlCtx = field "solutionurl" $ \item -> do
   let x = addSolutionsFolder $ toFilePath $ itemIdentifier item
   r3 <- getRoute $ setVersion Nothing $  fromFilePath x
   r1 <- getRoute $ setVersion (Just "titleline") $  fromFilePath x
   r2 <- getRoute $ setVersion (Just "pdfs") $  fromFilePath x
   case  (r3 <|> r2 <|> r1) of
         Just s -> return s
         Nothing -> fail "no solution"

solutionBodyCtx = field "solutionbody" $ \item -> do
   let x = addSolutionsFolder $ toFilePath $ itemIdentifier item
   r <- getRoute $ fromFilePath x
   case  r of
         Just s -> loadSnapshotBody ( fromFilePath s ) "soln" 
         Nothing -> return "no solution" -- fail "no solution"

solutionPdfUrlCtx = field "solutionpdfurl" $ \item -> do
   return $ addPdfFolder $ addSolutionsFolder $ toFilePath $ itemIdentifier item

correspondingSolutionFile s = "solutions/" ++ (reverse $ takeWhile (/= '/') $ reverse s)


strippedfileCtx = strippedfileCtx' `mappend` fileDigitCtx

strippedfileCtx' ::  Context a
strippedfileCtx' = field "strippedfile" $ return . toStrippedFile . toFilePath . itemIdentifier

fileDigitCtx ::  Context a
fileDigitCtx = field "filedigit" $ return . showFileDigit

exerciseTitleCtx :: Context a
exerciseTitleCtx = field "title" $ \item -> do
  let d = showFileDigit item
  --let fp = toFilePath $ itemIdentifier item
  case identifyItem item of
    Slide ->  return $ "Lecture slide "++ d
    Assignment ->  return $ "Exercise sheet " ++ d
    Solution ->  return $ "Hints / Solutions " ++ d
    Announcement -> return $ "Announcement"
    Post -> fail "Comment"



feedDescriptionCtx :: Context String
feedDescriptionCtx = field "description" $ \item -> do
  let d = showFileDigit item
  --let fp = toFilePath $ itemIdentifier item
  case identifyItem item of
    Slide ->  return $ "Lecture slide "++ d ++ " has been posted."
    Assignment ->  return $ "Exercise sheet " ++ d ++ " has been posted."
    Solution ->  return $ "Hints / Solutions " ++ d ++ " has been posted."
    Post ->  return $ "A comment "  ++ " has been posted."
    Announcement -> return $ itemBody item
  {-
  if "texslides" `isInfixOf` fp then (return $ "Lecture slide "++ d)
    else
        return $ case d of
            "0" -> "Announcement"
            _ -> ("Exercise sheet " ++ d)
-}
  --return . ((++) <$> const "Exercise sheet " <*> showFileDigit)

showFileDigit = show . extractDigit . toStrippedFile . toFilePath . itemIdentifier



toPDFFile = (++".pdf") . toStrippedFile
toStrippedFile = reverse . takeWhile (/='/') . tail . dropWhile (/='.') . reverse


pdfUrlCtx = field "pdfurl" $ \item -> do
   return $ addPdfFolder $ toFilePath $ itemIdentifier item

pdfUrlCtxUncertain = field "pdfurl" $ \item -> do
   let x = addPdfFolder $ toFilePath $ itemIdentifier item
   r <- getRoute $ fromFilePath x
   case  r of
         Just s -> return s
         Nothing -> fail "no pdfurl"

checkPdfCtx = field "haspdf" $ \item -> do
   let x = addPdfFolder $ toFilePath $ itemIdentifier item
   r <- getRoute $ fromFilePath x
   return $ case  r of
              --Just s -> "<a href=\"/" ++ x ++ "\"><img src=\"/files/pdf.png\" alt=\"PDF\" height=\"15\"></a>"
              Just s -> "<a href=\"/" ++ x ++ "\">PDF version</a>"
              Nothing -> ""
  

addPdfFolder s = reverse $ h ++ "/sfdp" ++ (dropWhile (/='/') f)
  where f = ("fdp" ++ ) $ dropWhile (/='.') $ reverse s
        h = takeWhile (/='/') f

addSolutionsFolder s = reverse $ h ++ "/snoitulos" ++ (dropWhile (/='/') f)
  where f = reverse s
        h = takeWhile (/='/') f

pdfCtx = pdfUrlCtx -- checkPdfCtx -- "" -- pdfCtx' "."
--pdfUpCtx = checkPdfCtx ".." -- pdfCtx' ".."

pdfCtx' :: String -> Context a 
pdfCtx' p = checkPdfCtx `mappend` (field "pdfversion" $ chkCtx p)

chkCtx p item = do
    metadata <- getMetadataField (itemIdentifier item) "linkpdf"
    return $ case metadata of
               Just "true" ->  p ++ "/pdfs/"++ toPDFFile (toFilePath $ itemIdentifier item)
               Just s -> p ++ "/pdfs/"++ s
               Nothing -> ""



chkCtx' p item = do
    metadata <- getMetadataField (itemIdentifier item) "linkpdf"
    return $ case metadata of
               Just "true" ->  p ++ "/pdfs/"++ toPDFFile (toFilePath $ itemIdentifier item)
               Just s -> p ++ "./pdfs/"++ s
               Nothing -> ""



slideDescriptionCtx = field "description" $ \item -> do
  let fp = toFilePath $ itemIdentifier item
  if "texslides" `isInfixOf` fp then (return "Lecture slide") else fail "not slide"


extractDigit :: String -> Int
--extractDigit = read . takeWhile isDigit .  dropWhile (not . isDigit)
extractDigit = read' . reverse . takeWhile isDigit .  reverse
  where read' n = case readMaybe n of
          Just m -> m
          _ -> 0



sortAssignments = sortBy (\x y -> compare (extractDigit $ toStrippedFile $ toFilePath $ itemIdentifier x) (extractDigit $ toStrippedFile $ toFilePath $ itemIdentifier y))


stringToByte = BU.fromString


postPdfRoute = (gsubRoute "posts/" (const "posts/pdfs/")) `composeRoutes` setExtension "pdf"


assignmentPdfRoute = (gsubRoute "assignments/" (const "assignments/pdfs/")) `composeRoutes` setExtension "pdf"


solutionPdfRoute = (gsubRoute "solutions/" (const "solutions/pdfs/")) `composeRoutes` setExtension "pdf"



localModifiedTime :: Context a
localModifiedTime = field "mtime" $ \i -> do
    mtime    <- getItemModificationTime (itemIdentifier i)
    timeZone <- unsafeCompiler getCurrentTimeZone
    let localTime = utcToLocalTime timeZone mtime
    return $ formatTime defaultTimeLocale "%I:%M %p - %e %B, %Y " localTime

updatedTime :: Context a
updatedTime = field "updated" $ \i -> do
    mtime    <- getItemModificationTime (itemIdentifier i)
    timeZone <- unsafeCompiler getCurrentTimeZone
    let localTime = utcToLocalTime timeZone mtime
    return $ formatTime defaultTimeLocale "%FT%T+5:30" localTime
    --return $ formatTime defaultTimeLocale "%I:%M %p - %e %B, %Y " localTime



-- NOT NEEDED
fileDigit = show . extractDigit . toStrippedFile

addLatexPreamble :: B.ByteString -> Compiler B.ByteString
addLatexPreamble x = do
  fp <- getResourceFilePath
  r <- getRoute $ fromFilePath fp
  case  r of
         Just s -> return $ stringToByte $ "\\documentclass{article}\n\\usepackage{amssymb}\n\\date{}\\title{Exercise sheet " ++ fileDigit s ++ "}\n" ++ "\\begin{document}\n \\maketitle\n" ++ BU.toString x ++ "\n \\end{document}"
         Nothing -> fail "no pdfurl"



getRoute' :: Identifier -> Compiler (Maybe FilePath)
getRoute' identifier = do
    provider <- compilerProvider <$> compilerAsk
    routes   <- compilerRoutes <$> compilerAsk
    -- Note that this makes us dependend on that identifier: when the metadata
    -- of that item changes, the route may change, hence we have to recompile
    (mfp, um) <- compilerUnsafeIO $ runRoutes routes provider identifier
    compilerTellDependencies [IdentifierDependency identifier]
    fp <- getResourceFilePath
    return mfp


forceDep = do
  identifier <- fromFilePath . addSolutionsFolder <$> getResourceFilePath
  compilerTellDependencies [IdentifierDependency identifier]

forceDeps = do
  is <- getMatches "*/solutions/*"
  compilerTellDependencies $ map IdentifierDependency is




modificationChronologically =
    sortByM $ getItemModificationTime . itemIdentifier
  where
    sortByM :: (Monad m, Ord k) => (a -> m k) -> [a] -> m [a]
    sortByM f xs = liftM (map fst . sortBy (comparing snd)) $
                   mapM (\x -> liftM (x,) (f x)) xs


recentlyModifiedFirst = liftM reverse . modificationChronologically



myFeedConfiguration :: FeedConfiguration
myFeedConfiguration = FeedConfiguration
    { feedTitle       = "MTH406 Theory of Computation"
    , feedDescription = "Get exercises and announcements"
    , feedAuthorName  = "Shane D'Mello"
    , feedAuthorEmail = "shane@iisermohali.ac.in"
    , feedRoot        = "http://sejdm.github.io/mth406"
    }


feeds = do
    let feedCtx =   feedDescriptionCtx
          `mappend` exerciseTitleCtx
          `mappend` assignmentCtx
          --`mappend` bodyField "description"
          `mappend` updatedTime
          `mappend` titleField "title"
          `mappend` exerciseTitleCtx

    assignments <- loadAllSnapshots ("assignments/*.tex" .&&. hasNoVersion) "content"
    solutions <- loadAllSnapshots ("*/solutions/*.tex" .&&. hasNoVersion) "content"
    announcements <- loadAllSnapshots ("announcements/*" .&&. hasNoVersion) "content"
    comments <- loadAllSnapshots ("posts/*" .&&. hasNoVersion) "content"   :: Compiler [Item String]
    slides <- loadAllSnapshots "texslides/*" "rawslide"  :: Compiler [Item String]

    posts <- recentlyModifiedFirst (assignments ++ announcements ++ slides ++ solutions ++ comments)

    return (feedCtx, posts)


data ItemType = Slide | Assignment | Solution | Post | Announcement

identifyItem item | "texslides/" `isInfixOf` fp = Slide
                  | "solutions/" `isInfixOf` fp = Solution
                  | "assignments/" `isInfixOf` fp = Assignment
                  | "posts/" `isInfixOf` fp = Post
                  | "announcements/" `isInfixOf` fp = Announcement
  where fp = toFilePath $ itemIdentifier item


commentTitleContext :: Context a
commentTitleContext = field "title" $ \item -> do
    metadata <- getMetadata (itemIdentifier item)
    return $ fromMaybe "A comment" $ lookupString "title" metadata



previousUrl :: Pattern -> Item String -> Compiler String
previousUrl s post = do
    posts <- getMatches s
    let ident = itemIdentifier post
        sortedPosts = posts
        ident' = itemBefore sortedPosts ident
    case ident' of
        -- Just i -> ctdi i >> (fmap (maybe empty  toUrl) . getRoute) i
        Just i -> (fmap (maybe empty  toUrl) . getRoute) i
        Nothing -> empty


nextUrl :: Pattern -> Item String -> Compiler String
nextUrl s post = do
    posts <- getMatches s
    let ident = itemIdentifier post
        sortedPosts = posts
        ident' = itemAfter sortedPosts ident
    case ident' of
--        Just i -> ctdi i >> (fmap (maybe empty  toUrl) . getRoute) i
        Just i -> (fmap (maybe empty  toUrl) . getRoute) i
        Nothing -> empty


ctdi i = compilerTellDependencies [IdentifierDependency i]

itemAfter :: Eq a => [a] -> a -> Maybe a
itemAfter xs x =
    lookup x $ zip xs (tail xs)

itemBefore :: Eq a => [a] -> a -> Maybe a
itemBefore xs x =
    lookup x $ zip (tail xs) xs

urlOfPost :: Item String -> Compiler String
urlOfPost =
    fmap (maybe empty  toUrl) . getRoute . itemIdentifier


prevNextCtx s = field "nextPost" (nextUrl s) `mappend` field "prevPost" (previousUrl s)
--prevNextCtx s = field "nextPost" (const $ return "ok") `mappend` field "prevPost" (const $ return "x")



---
-- Without dependencies
getMatches' :: Pattern -> Compiler [Identifier]
getMatches' pattern = do
    universe <- compilerUniverse <$> compilerAsk
    let matching = filterMatches pattern $ S.toList universe
        set'     = S.fromList matching
    return matching



applyOnlyIfPDfExists a b = do
  fp <- getResourceFilePath
  r <- getRoute $ fromFilePath $ addPdfFolder fp
  case r of
    Nothing -> b
    _ -> a
     

pandocAddLinkDirFilter d = walk f
  where f (Link a xs t) = Link a xs (d `mappend` t)
