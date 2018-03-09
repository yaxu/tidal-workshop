import Sound.Tidal.Context (p, superDirtSetters, cpsUtils)
import Language.Haskell.Interpreter as Hint
import System.Exit
import System.Environment (getArgs)
import Control.Concurrent
import System.Cmd
import Text.HTML.TagSoup.Entity (lookupEntity)
import System.Posix.Resource

unescapeEntities :: String -> String
unescapeEntities [] = []
unescapeEntities ('&':xs) = 
  let (b, a) = break (== ';') xs in
  case (lookupEntity b, a) of
    (Just c, ';':as) ->  c  ++ unescapeEntities as    
    _                -> '&' : unescapeEntities xs
unescapeEntities (x:xs) = x : unescapeEntities xs

data Response = OK {parsed :: ParamPattern}
              | Error {errorMessage :: String}

seconds = 20

cpsVal = 0.75

main = do a <- getArgs
          let fn = head a
          setResourceLimit ResourceCPUTime (ResourceLimits (ResourceLimit 4) (ResourceLimit 8))
          code <- getContents
          r <- runTidal $ unescapeEntities code
          respond fn r
   where respond fn (OK p)
           = do (cpsSet, getNow) <- cpsUtils
                cpsSet cpsVal
                (d, _) <- superDirtSetters getNow
                system $ "ecasound -t:" ++ show (seconds+2) ++ " -i jack,SuperCollider -o " ++ fn ++ " &"
                d p
                threadDelay (seconds * 1000000)
                exitSuccess
         respond _ (Error s) = do putStrLn ("error: " ++ s)
                                  exitFailure
                   
libs = ["Prelude","Sound.Tidal.Context","Sound.OSC.Type","Sound.OSC.Datum"]

runTidal  :: String -> IO (Response)
runTidal code =
  do result <- do Hint.runInterpreter $ do
                  Hint.set [languageExtensions := [OverloadedStrings]]
                  --Hint.setImports libs
                  Hint.setImportsQ $ (Prelude.map (\x -> (x, Nothing)) libs) ++ [("Data.Map", Nothing)]
                  p <- Hint.interpret code (Hint.as :: ParamPattern)
                  return p
     let response = case result of
          Left err -> Error (parseError err)
          Right p -> OK p -- can happen
         parseError (UnknownError s) = "Unknown error: " ++ s
         parseError (WontCompile es) = "Compile error: " ++ (intercalate "\n" (Prelude.map errMsg es))
         parseError (NotAllowed s) = "NotAllowed error: " ++ s
         parseError (GhcException s) = "GHC Exception: " ++ s
         parseError _ = "Strange error"
     return response
