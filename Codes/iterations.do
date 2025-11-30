
* Instructions:
* 1. Change the directory based on where the file is stored in your local drive
* 2. Update filename: if you are running per-dollar impacts (MVPF), use Pooled_Estimates_MVPF; if just effect size use "Pooled_Estimates"
* 3. Change the effect size

* NEW CODE with the following key adjustments:
	* - Restricting the data to Advanced/LMIC countries 
	* - Keeping only Voucher, Charter, and Subsidy sheets in Excel output file
	* - Summarizing test subjects (English, Math, Language, Overall) as well 

clear all 

* Define the directory for Excel output
global directory "\\tsclient\C\Users\Admin\Documents\GMU\Dr Kugler\School choice\Datasets"

* Load data
use "$directory/Merged-Data-06.11.24.dta", clear

* Rename Combined to Overall in Test subject (Typeofsubjectcombinedspecif)
tab Typeofsubjectcombinedspecif
tab Outcometype Typeofsubjectcombinedspecif
replace Typeofsubjectcombinedspecif = "Overall" if Typeofsubjectcombinedspecif == "Combined"

*--------/ Change these options /---------------------------------------------*

* Filename for the Excel output (change options)
*local filename "Pooled_Estimates_31.12.24_Developed"
*local filename "Pooled_Estimates_31.12.24_Developing"
*local filename "Pooled_Estimates_MVPF_31.12.24_Developed"
local filename "Pooled_Estimates_MVPF_31.12.24_Developing"

* Process data for Developed or Developing countries (change options)
*keep if Incomeclassification == "Advanced"
keep if Incomeclassification == "LMIC"

* Identify meta-analysis variables
gen studyid = PaperID
// These options are for estimates:
*gen eff_size = Effectsize	
*gen std_error = SEstd
// These options are for MVPF estimates:
gen eff_size = 1000*Effectsize/ppp_cost_comp
gen std_error = 1000*SEstd/ppp_cost_comp

*-----------------------------------------------------------------------------*

* Create group variables
clonevar group1 = PPPtype
clonevar group2 = Incomeclassification
clonevar group3 = Yearlevel
clonevar group4 = Outcometype
clonevar group5 = Accountability
clonevar group6 = Methods
clonevar group7 = Equity
clonevar group8 = Maturity
clonevar group9 = JournalType if JournalType != "0"
gen group10 = "All"
clonevar group11 = Effectlabel // ITT vs TOT
clonevar group12 = Typeofsubjectcombinedspecif // New group for Subject (English, Language, Math, Overall)

* Define the groups
local groups "group1 group2 group3 group4 group5 group6 group7 group8 group9 group10 group11 group12"

* Define labels for the output sheets (only the necessary ones)
local labels "Voucher Charter Subsidy"

* Apply meta set outside the loop
meta set eff_size std_error, studylabel(studyid)

* Loop for conditions (only Voucher, Charter, and Subsidy)
forvalues i = 1/3 {
    * Preserve the data for each condition
    preserve

    * Apply filters for each condition
    if `i' == 1 {
        keep if PPPtype == "voucher"
    }
    else if `i' == 2 {
        keep if PPPtype == "charter"
    }
    else if `i' == 3 {
        keep if PPPtype == "subsidy"
    }

    * Define the Excel sheet label with income classification
    local label : word `i' of `labels'
    putexcel set "${directory}/`filename'.xlsx", sheet("`label'") modify

    * Write column headers to the Excel sheet
    putexcel A1 = "Group" B1 = "Subgroup" C1 = "Theta" D1 = "SE" E1 = "p-value" F1 = "N"

    * Initialize row counter
    local row = 2

    * Loop over each group and subgroup
    foreach group of local groups {
        local group_label : variable label `group'
        if "`group_label'" == "" local group_label "`group'"
        levelsof `group', local(subgroups)

        foreach subgroup of local subgroups {
            * Run meta-analysis for the current subgroup
            capture meta summarize if `group' == "`subgroup'"
            if _rc != 0 continue

            * Store results
            local theta = r(theta)
            local se = r(se)
            local N = r(N)
            local z = `theta' / `se'
            local pval = 2 * (1 - normal(abs(`z')))

            * Write results to the Excel sheet
            putexcel A`row' = "`group_label'" B`row' = "`subgroup'" C`row' = `theta' D`row' = `se' E`row' = `pval' F`row' = `N'

            * Increment row counter
            local row = `row' + 1
        }
    }

    * Restore the data for the next condition
    restore
}

