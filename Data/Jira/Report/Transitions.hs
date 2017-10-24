module Data.Jira.Report.Transitions (parseCSV) where

import Control.Arrow
import Control.Applicative
import Text.CSV (CSV)
import Text.Read
import System.Environment
import Data.Time.Clock
import Data.Time.Format
import Data.Jira.Issue
import Data.Jira.Transition

parseCSV :: CSV -> [Maybe Transition]

parseCSV = fmap parseRow

parseRow [ issueKey, issueType, priority, fromStatus, toStatus, interval, executionTimes, user, date, storyPoints ] = do
    interval' <- parseInterval interval
    date' <- parseTimeM False defaultTimeLocale "%e-%b-%y %H:%M:%S" date
    executionTimes' <- readMaybe executionTimes
    let storyPoints' = readMaybe storyPoints
    let priority' = case priority of "" -> Nothing
                                     p -> Just p
    return $ Transition (Issue issueType issueKey storyPoints' priority')
                        fromStatus toStatus interval' date' user executionTimes'

parseRow _ = Nothing

parseInterval = words >>> map parseTimeWithUnit >>> foldl (liftA2 (+)) (Just 0)

parseTimeWithUnit str = do
    value <- readMaybe $ init str
    unit <- parseTimeUnit $ last str
    return $ value * unit

parseTimeUnit unit = case unit of 's' -> Just $ 1
                                  'm' -> Just $ 60
                                  'h' -> Just $ 60 * 60
                                  'd' -> Just $ 60 * 60 * 24
                                  'w' -> Just $ 60 * 60 * 24 * 5
                                  'y' -> Just $ 60 * 60 * 24 * 5 * 52
                                  _   -> Nothing
