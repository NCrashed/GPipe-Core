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
{-# LANGUAGE InstanceSigs #-}
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

instance HasField "xy" (V2 a) (V2 a) where 
    getField = id 

instance HasField "xy" (V3 a) (V2 a) where 
    getField (V3 x y _) = V2 x y 

instance HasField "xy" (V4 a) (V2 a) where 
    getField (V4 x y _ _) = V2 x y 

instance HasField "yx" (V2 a) (V2 a) where 
    getField (V2 x y) = V2 y x

instance HasField "yx" (V3 a) (V2 a) where 
    getField (V3 x y _) = V2 y x 

instance HasField "yx" (V4 a) (V2 a) where 
    getField (V4 x y _ _) = V2 y x 

instance HasField "xyz" (V3 a) (V3 a) where 
    getField = id

instance HasField "xyz" (V4 a) (V3 a) where 
    getField (V4 x y z _) = V3 x y z

instance HasField "yxz" (V3 a) (V3 a) where 
    getField (V3 x y z)= V3 y x z

instance HasField "yxz" (V4 a) (V3 a) where 
    getField (V4 x y z _) = V3 y x z

instance HasField "zxy" (V3 a) (V3 a) where 
    getField (V3 x y z)= V3 z x y

instance HasField "zxy" (V4 a) (V3 a) where 
    getField (V4 x y z _) = V3 z x y

instance HasField "zyx" (V3 a) (V3 a) where 
    getField (V3 x y z)= V3 z y x

instance HasField "zyx" (V4 a) (V3 a) where 
    getField (V4 x y z _) = V3 z y x

instance HasField "xzy" (V3 a) (V3 a) where 
    getField (V3 x y z)= V3 x z y

instance HasField "xzy" (V4 a) (V3 a) where 
    getField (V4 x y z _) = V3 x z y

instance HasField "yzx" (V3 a) (V3 a) where 
    getField (V3 x y z)= V3 y z x

instance HasField "yzx" (V4 a) (V3 a) where 
    getField (V4 x y z _) = V3 y z x