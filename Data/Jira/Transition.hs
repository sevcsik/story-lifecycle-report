module Data.Jira.Transition (Transition(..)) where

import Data.Jira.Issue
import Data.Time.Clock

type Status = String
type Seconds = Int

data Transition = Transition { issue :: Issue
                             , fromStatus :: Status
                             , toStatus :: Status
                             , interval :: Seconds
                             , date :: UTCTime
                             , user :: String
                             , executionTimes :: Int
                             } deriving Show
