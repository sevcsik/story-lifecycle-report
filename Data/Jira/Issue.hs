module Data.Jira.Issue (Issue(..)) where

data Issue = Issue { issueType :: String
                   , key :: String
                   , storyPoints :: Maybe Float
                   , priority :: Maybe String
                   } deriving (Eq, Show)
