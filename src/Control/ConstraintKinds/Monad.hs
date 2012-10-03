{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE TypeFamilies #-}
-- {-# LANGUAGE NoImplicitPrelude #-}

module Control.ConstraintKinds.Monad
    where

import GHC.Prim
import Control.Applicative
import Control.Monad as Monad
import Prelude hiding (Monad, (>>=), (>>))
import qualified Prelude as Prelude

import qualified Data.Foldable as F
import qualified Data.List as L
import qualified Data.Traversable as T
import qualified Data.Vector as V
import qualified Data.Vector.Unboxed as VU
import qualified Data.Vector.Generic as VG

import Control.ConstraintKinds.Foldable
import Control.ConstraintKinds.Functor

-------------------------------------------------------------------------------
-- class Monad

class Monad m where
    type MonadConstraint t x :: Constraint
    type MonadConstraint t x = ()

    (>>=)       :: {-forall a b. -}m a -> (a -> m b) -> m b
    (>>)        :: {-forall a b. -}m a -> m b -> m b
    return      :: a -> m a
    fail        :: String -> m a

    {-# INLINE (>>) #-}
    m >> k      = m >>= \_ -> k
    fail s      = error s
    
-------------------------------------------------------------------------------
-- instances

instance Control.ConstraintKinds.Monad.Monad [] where
    (>>=)       = Monad.(>>=)
    (>>=)       = Monad.(>>)
    return      = Monad.return
    fail        = Monad.fail
--     m >>= k             = foldr ((++) . k) [] m
--     m >> k              = foldr ((++) . (\ _ -> k)) [] m
--     return x            = [x]
--     fail _              = []