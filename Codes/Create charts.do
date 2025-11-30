
* Load the Excel file containing the datasets
global directory "/Users/angelosantos/Library/CloudStorage/OneDrive-GeorgeMasonUniversity-O365Production/School Choice/Datasets"

* Load data
use "$directory/Merged-Data.dta", clear

* Provide the name of the Excel file to be created
local filename "Pooled_Estimates"

* Identify meta-analysis variables
gen studyid = PaperID
gen eff_size = Effectsize
gen std_error = SEstd


*====================================================================================
* 1. Data restrictions:
*====================================================================================
*keep if JournalType != "Not peer-reviewed" & JournalType!="0"

*====================================================================================
* 2. Setting the meta variables (Random effects)
*====================================================================================


*====================================================================================
* 4. Heterogeneity 
*====================================================================================

* Define grouping variables
local groups "group1 group2 group3 group4 group5 group6 group7 group8 group9 group10"

* Create grouping variables 
* Required that variables are in string
clonevar group1 = PPPtype
clonevar group2 = Incomeclassification
clonevar group3 = Yearlevel
clonevar group4 = Outcometype
clonevar group5 = Accountability
clonevar group6 = Methods
clonevar group7 = Equity
clonevar group8 = Maturity
gen group9 = "For " + PPPtype + ": " + Maturity if !missing(PPPtype) & !missing(Maturity)
clonevar group10 = JournalType if JournalType!="0"


/*

For ease of setting unassigned groups to missing: Important to make program work
gen group1 = .
gen group2 = .
gen group3 = .
gen group4 = .
gen group5 = .
gen group6 = .
gen group7 = .
gen group8 = .
gen group9 = .
gen group10 = .

*/

*-----Do nothing below------*


*====================================================================================
* 4. Export to Excel with results for each group
*====================================================================================
* Create an Excel file and write headers
putexcel set "${directory}/`filename'.xlsx", replace
putexcel A1 = "Group" B1 = "Subgroup" C1 = "Theta" D1 = "SE" E1 = "p-value" F1 = "N"

* Initialize a row counter for Excel output
local row = 2

* Set metadata
meta set eff_size std_error, studylabel(studyid) 

* Loop over each group
foreach group of local groups {
    * Get the label for the current group variable
    local group_label : variable label `group'
    
    * If there is no label, fall back to using the variable name
    if "`group_label'" == "" local group_label "`group'"
    
    * Get the distinct values for the current group
    levelsof `group', local(subgroups)

    * Loop through each subgroup within the current group
    foreach subgroup of local subgroups {
        
        * Run the meta-analysis for the current subgroup
        meta summarize if `group' == "`subgroup'"
        
        * Store the results for the current subgroup
        local theta = r(theta)
        local se = r(se)
        local N = r(N)
        local z = `theta' / `se'
        local pval = 2 * (1 - normal(abs(`z')))
        
        * Write the results to the Excel file with the variable label in column A
        putexcel A`row' = "`group_label'" B`row' = "`subgroup'" C`row' = `theta' D`row' = `se' E`row' = `pval' F`row' = `N'

        * Increment the row counter
        local row = `row' + 1
    }
}



