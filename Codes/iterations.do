* Define the directory for Excel output
global directory "/Users/angelosantos/Library/CloudStorage/OneDrive-GeorgeMasonUniversity-O365Production/School Choice/Datasets"

* Load data
use "$directory/Merged-Data.dta", clear

* Filename for the Excel file (options: "Pooled_Estimates_MVPF" or ""Pooled_Estimates")
local filename "Pooled_Estimates"

* Identify meta-analysis variables
gen studyid = PaperID
gen eff_size = Effectsize
gen std_error = SEstd

/*
gen eff_size = 1000*Effectsize/ppp_cost_comp
gen std_error = 1000*SEstd/ppp_cost_comp

gen eff_size = Effectsize
gen std_error = SEstd
*/

* Create group variables only once, outside the loop
clonevar group1 = PPPtype
clonevar group2 = Incomeclassification
clonevar group3 = Yearlevel
clonevar group4 = Outcometype
clonevar group5 = Accountability
clonevar group6 = Methods
clonevar group7 = Equity
clonevar group8 = Maturity
clonevar group9 = JournalType if JournalType!="0"
gen group10 = "All"


* Define the groups
local groups "group1 group2 group3 group4 group5 group6 group7 group8 group9 group10"

* Set the output Excel file once, outside the loop
putexcel set "${directory}/`filename'.xlsx", replace

* Define labels for each sheet
local labels "All Voucher Charter Subsidy Primary Secondary Vocational Published Advanced LMIC"

* Apply meta set outside the loop
meta set eff_size std_error, studylabel(studyid)

* Loop over each condition and generate results
forvalues i = 1/10 {
    * Preserve the original data before applying each condition
    preserve
    
    * Set the label for the current sheet
    local label : word `i' of `labels'

    * Apply restrictions based on iteration
    if `i' == 1 {
        * All data - do nothing
    }
    else if `i' == 2 {
        keep if PPPtype == "voucher"
    }
    else if `i' == 3 {
        keep if PPPtype == "charter"
    }
    else if `i' == 4 {
        keep if PPPtype == "subsidy"
    }
    else if `i' == 5 {
        keep if Yearlevel == "Primary"
    }
    else if `i' == 6 {
        keep if Yearlevel == "Secondary"
    }
    else if `i' == 7 {
        keep if Yearlevel == "Vocational"
    }
    else if `i' == 8 {
        keep if inlist(JournalType, "Economics", "Non-Economics")
    }

	else if `i' == 9 {
        keep if Incomeclassification == "Advanced"
    }
	
	else if `i' == 10 {
        keep if Incomeclassification == "LMIC"
    }
	


    * Set the Excel sheet for current iteration with the correct label
    putexcel set "${directory}/`filename'.xlsx", sheet("`label'") modify
    putexcel A1 = "Group" B1 = "Subgroup" C1 = "Theta" D1 = "SE" E1 = "p-value" F1 = "N"

    * Initialize row counter
    local row = 2

    * Loop over each group and subgroup
    foreach group of local groups {
        local group_label : variable label `group'
        if "`group_label'" == "" local group_label "`group'"

        levelsof `group', local(subgroups)

        foreach subgroup of local subgroups {
            * Run meta-analysis for subgroup
            capture meta summarize if `group' == "`subgroup'"
            if _rc != 0 continue

            * Store results
            local theta = r(theta)
            local se = r(se)
            local N = r(N)
            local z = `theta' / `se'
            local pval = 2 * (1 - normal(abs(`z')))

            * Write to Excel sheet
            putexcel A`row' = "`group_label'" B`row' = "`subgroup'" C`row' = `theta' D`row' = `se' E`row' = `pval' F`row' = `N'

            * Increment row counter
            local row = `row' + 1
        }
    }

    * Restore the original data for the next iteration
    restore
}
