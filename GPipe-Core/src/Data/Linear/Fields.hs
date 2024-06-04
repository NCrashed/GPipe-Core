-----------------------------------------------------------------------------
--
-- Module      :  Data.Linear.Fields
-- Copyright   :  NCrashed
-- License     :  MIT
--
-- Maintainer  :  NCrashed
-- Stability   :  Experimental
-- Portability :  Portable
--
-- | The module provides additional orphan instances that allows to access vector 
-- and matricies fields with simple syntaxis like:
-- @
--   v.x + v.y 
-- @
-----------------------------------------------------------------------------
{-# LANGUAGE DataKinds #-}
module Data.Linear.Fields where 

import GHC.Records 
import Linear  

instance HasField "x" (V1 a) a where 
    getField (V1 x) = x 

instance HasField "x" (V2 a) a where 
    getField (V2 x _) = x 

instance HasField "x" (V3 a) a where 
    getField (V3 x _ _) = x 

instance HasField "x" (V4 a) a where 
    getField (V4 x _ _ _) = x 

instance HasField "y" (V2 a) a where 
    getField (V2 _ y) = y 

instance HasField "y" (V3 a) a where 
    getField (V3 _ y _) = y

instance HasField "y" (V4 a) a where 
    getField (V4 _ y _ _) = y

instance HasField "z" (V3 a) a where 
    getField (V3 _ _ z) = z

instance HasField "z" (V4 a) a where 
    getField (V4 _ _ z _) = z

instance HasField "w" (V4 a) a where 
    getField (V4 _ _ _ w) = w