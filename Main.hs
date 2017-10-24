import qualified Data.Jira.Report.Transitions as Transitions

import Text.CSV
import System.Environment

main = do
    args <- getArgs
    case args of 
        [ filename ] -> do
            fileContent <- readFile filename
            case parseCSV filename fileContent of
                Right csv -> putStrLn $ show $ Transitions.parseCSV csv
                Left error -> putStrLn $ show error
        _ -> putStrLn help

help = "Usage: story-lifecycle-report <INFILE>\n"
    ++ "  where INFILE is a CSV report from Jira's Transition report"


