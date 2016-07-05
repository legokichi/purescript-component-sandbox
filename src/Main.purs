module Main where

import Prelude (Unit, bind, ($))
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Data.Nullable (toMaybe)
import Data.Maybe (Maybe(..))
import DOM (DOM)
import DOM.HTML (window)
import DOM.HTML.Document (body)
-- import DOM.HTML.HTMLCanvasElement as Cnv
import DOM.HTML.Window (document)
import DOM.HTML.Types  (htmlDocumentToDocument, htmlElementToElement)
import DOM.Node.Node (appendChild)
import DOM.Node.Document (createElement)
import DOM.Node.Types (elementToNode)

main :: forall e. Eff (dom :: DOM, console :: CONSOLE | e) Unit
main = do
-- + Window
-- |     + window :: forall eff. Eff (dom :: DOM | eff) Window
-- |     |
  win <- window
-- + HTMLDocument
-- |     + document :: forall eff. Window -> Eff (dom :: DOM | eff) HTMLDocument
-- |     |
  doc <- document win 
-- + Element
-- |     + createElement :: forall eff. String -> Document -> Eff (dom :: DOM | eff) Element
-- |     |                      + ($) :: forall a b. (a -> b) -> a -> b
-- |     |                      | + htmlDocumentToDocument :: HTMLDocument -> Document
-- |     |                      | |                      + HTMLDocument
-- |     |                      | |                      |
  cnv <- createElement "canvas" $ htmlDocumentToDocument doc
-- + Nullable HTMLElement
-- |     + body :: forall eff. HTMLDocument -> Eff (dom :: DOM | eff) (Nullable HTMLElement)
-- |     |    + HTMLDocument
-- |     |    |
-- |     |    |
  bod <- body doc
--    + Maybe HTMLElement
--    |      + toMaybe :: forall a. Nullable a -> Maybe a
--    |      |       + Nullable HTMLElement
--    |      |       |
  let _bod = toMaybe bod
  case _bod of
    Nothing  -> do
      log "shit!"
--       + HTMLElement
--       |
    Just __bod -> do
--        + Element
--        |        + elementToNode :: Element -> Node
--        |        |             + forall a b. (a -> b) -> a -> b
--        |        |             | + htmlElementToElement :: HTMLElement -> Element
--        |        |             | |                    + HTMLElement
--        |        |             | |                    |
      let ___bod = elementToNode $ htmlElementToElement __bod
      let _cnv   = elementToNode cnv
--    + appendChild :: forall eff. Node -> Node -> Eff (dom :: DOM | eff) Node
--    |            + Node
--    |            |   + Node
--    |            |   |
      appendChild _cnv ___bod
      log "Hello sailor!"