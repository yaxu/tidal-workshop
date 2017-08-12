module Sound.Tidal.Light where

import Sound.Tidal.Context
import Sound.Tidal.OscStream
import Sound.OSC.FD
import Sound.OSC.Datum
import qualified System.Hardware.Serialport as SP
import Control.Monad
import qualified Data.ByteString.Char8 as B
import Data.Colour.SRGB
import Data.Colour.Names
import Control.Concurrent.MVar
import GHC.Float

data Sound = Sound {rS :: Float,
                    gS :: Float,
                    bS :: Float,
                    panS :: Float,
                    durS :: Int,
                    ageS :: Int,
                    beginS :: Float,
                    endS :: Float
                   }

fps = 100
light :: Shape
light = Shape {params = [s_p,
                         n_p,
                         pan_p,
                         begin_p,
                         end_p,
                         dur_p
                         ],
               cpsStamp = True,
               latency = 0.29
              }
lightSlang = OscSlang {
  path = "/lightrgb",
  timestamp = NoStamp,
  namedParams = False,
  preamble = []
  }
lightBackend = do s <- makeConnection "127.0.0.1" 9099 lightSlang
                  return $ Backend s (\_ _ _ -> return ())
lightServer = do s <- udpServer "127.0.0.1" 9099
                 output <- SP.openSerial "/dev/ttyUSB0" (SP.defaultSerialSettings {SP.commSpeed = SP.CS115200})
                 sM <- startQueue output
                 forkIO $ lightLoop s output sM
lightLoop s output sM = do m <- recvMessage s
                           act m output sM
                           lightLoop s output sM
act (Just (Message "/lightrgb" [Float cps', ASCII_String s', Int32 n', Float pan', Float begin', Float end', Float dur'])) output sM =
  do let (r,g,b) = s2rgb $ B.unpack s' ++ ":" ++ show n'
     addQueue sM $ Sound r g b pan' (floor $ dur' * (fromIntegral fps)) 0 begin' end'
     return ()
act ( Just (Message "/lightrgb" [ASCII_String s])) output _ =
  do SP.send output $ B.pack $ (show s) ++ "\r"
     return ()
act m output _ = do putStrLn $ "message: " ++ show m
                    return ()
to256 f = show $ floor (f * 255)
lightStream = do backend <- lightBackend
                 stream backend light
c2rgb = ((\c -> (to256 $ channelRed c) ++ "r" ++ (to256 $ channelGreen c) ++ "g" ++ (to256 $ channelBlue c) ++ "b") . toSRGB)
s2rgb = ((\c -> (double2Float $ channelRed c, double2Float $ channelGreen c, double2Float $ channelBlue c)) . toSRGB . stringToColour')
-- sendLeft _ _ _ _ 0 = return ()
sendLeft output r g b l = do SP.send output $ B.pack $ to256 r ++ "r\r"
                             SP.send output $ B.pack $ to256 g ++ "g\r"
                             SP.send output $ B.pack $ to256 b ++ "b\r"
                             SP.send output $ B.pack $ to256 l ++ "l\r"
                             return ()
-- sendRight _ _ _ _ 0 = return ()
sendRight output r g b l = do SP.send output $ B.pack $ to256 r ++ "R\r"
                              SP.send output $ B.pack $ to256 g ++ "G\r"
                              SP.send output $ B.pack $ to256 b ++ "B\r"
                              SP.send output $ B.pack $ to256 l ++ "L\r"
                              return ()
startQueue output= do sM <- newMVar []
                      forkIO $ runQueue sM output
                      return sM
runQueue sM output
  = do sounds <- takeMVar sM
       let sounds' = filter (\s -> (durS s) > (ageS s)) $ map (\s -> s {ageS = (ageS s) + 1}) sounds
           splitted = map splitSound sounds'
           ls = map fst splitted
           rs = map snd splitted
           lr = maximum' $ map (\(r,_,_) -> r) ls
           lg = maximum' $ map (\(_,g,_) -> g) ls
           lb = maximum' $ map (\(_,_,b) -> b) ls
           rr = maximum' $ map (\(r,_,_) -> r) rs
           rg = maximum' $ map (\(_,g,_) -> g) rs
           rb = maximum' $ map (\(_,_,b) -> b) rs
       sendLeft output lr lg lb 1
       sendRight output rr rg rb 1
       putMVar sM sounds'
       threadDelay (1000000 `div` fps)
       -- putStrLn $ "left: " ++ (show $ length sounds')
       runQueue sM output
addQueue sM newSound = do s <- takeMVar sM
                          putMVar sM (newSound:s)
splitSound s = (l, r)
  where leftch = cos((pi / 2) * panS s) * (1-age'')
        rightch = sin((pi / 2) * panS s) * (1-age'')
        l = ((rS s)*leftch, (gS s)*leftch, (bS s)*leftch)
        r = ((rS s)*rightch, (gS s)*rightch, (bS s)*rightch)
        age = ((fromIntegral $ ageS s) / (fromIntegral $ durS s))
        age' = (beginS s) + (diff * age)
        diff = (endS s) - (beginS s)
        age'' = sin((pi / 2) * age')
maximum' [] = 0
maximum' xs = maximum xs

stringToColour' ('b':'d':_) = blue
stringToColour' ('c':'p':_) = yellow
stringToColour' ('k':'u':'r':'t':_) = blue
stringToColour' ('s':'n':_) = green
stringToColour' ('s':'d':_) = green
stringToColour' ('c':'l':'a':'u':'s':_) = red
stringToColour' s = stringToColour s
