{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_tidal_light (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,0,1] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/alex/.cabal/bin"
libdir     = "/home/alex/.cabal/lib/x86_64-linux-ghc-8.0.1/tidal-light-0.0.1-500E6LFnd9d1CaPyYAL9O9"
dynlibdir  = "/home/alex/.cabal/lib/x86_64-linux-ghc-8.0.1"
datadir    = "/home/alex/.cabal/share/x86_64-linux-ghc-8.0.1/tidal-light-0.0.1"
libexecdir = "/home/alex/.cabal/libexec"
sysconfdir = "/home/alex/.cabal/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "tidal_light_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "tidal_light_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "tidal_light_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "tidal_light_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "tidal_light_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "tidal_light_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
