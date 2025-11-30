
* Load the Excel file containing the datasets
*global directory "/Users/angelosantos/Library/CloudStorage/OneDrive-GeorgeMasonUniversity-O365Production/School Choice/Datasets"
global directory "\\Client\C$\Users\Admin\Documents\GMU\Dr Kugler\School choice\Datasets"
global mainfile "${directory}/Database_Final_30.10.24.xlsx"
global access "Access"
global labormarket "Labor market"
global costs "Costs"
global equity "Equity"
global testscores "Test scores"
global metadata "Metadata"

* Append all files
import excel "${mainfile}", sheet("${testscores}") firstrow clear
tempfile main
save `main'

import excel "${mainfile}", sheet("${access}") firstrow clear
append using `main'
save `main', replace

import excel "${mainfile}", sheet("${labormarket}") firstrow clear
append using `main'
save `main', replace

import excel "${mainfile}", sheet("${equity}") firstrow clear
gen equity = 1
append using `main'
replace equity = 0 if missing(equity)
save `main', replace

* Merge costs
import excel "${mainfile}", sheet("${costs}") firstrow clear

* I will drop duplicated entry for ID = 7, the less expensive one to get the lowerbound of estimates
drop if PaperID == 7 & PPPcostperpupil == 8000

merge 1:m PaperID using `main', nogen
save `main', replace

* Load metadata and append
import excel "${mainfile}", sheet("${metadata}") firstrow clear
rename ID PaperID
keep PaperID Author Year Title Program Incomeclassification PPPtype JournalType FinanceofTeacherSalaries Schoolaccountability Studentaccountability Methodology Country

merge 1:m PaperID using `main', keep(using match) 

replace Country1 = Country if missing(Country1)

* Data cleaning
replace Outcometype = "Test Scores" if inlist(Outcometype, "Test score", "test scores")
replace Variable = "Labor Market" if inlist(Outcometype, "Earnings", "Employment")
replace Variable = "Enrollment" if Outcometype == "Enrollment"
replace Variable = "Test Scores" if Outcometype == "Test Scores" 

* Generate outcome per dollar spent
gen mvpf = Effectsize/PPPcostperpupil

* Drop Equity duplicates
duplicates tag PaperID Effectsize SEstd, gen(tag)
sort PaperID Effectsize

drop if tag>=1 & equity == 0

* Add method description in string
generate Methods = "Experimental" if Methodology == 1
replace Methods = "Quasi-experimental" if Methodology == 2
label var Methods "Evidence type"

* Add equity description in string
gen Equity = "Disadvantaged" if equity == 1
replace Equity = "Not disadvantaged" if equity == 0
label var Equity "Equity type"

* Add program age in string
gen Maturity = "1 year or less" if inrange(Programage, 0.0001, 1)
replace Maturity = "Between 1 and 2 years" if inrange(Programage, 1.0001, 2)
replace Maturity = "Between 2 and 4 years" if inrange(Programage, 2.0001, 4)
replace Maturity = "Between 4 and 8 years" if inrange(Programage, 4.0001, 8)
replace Maturity = "More than 8 years" if Programage>8 & !missing(Programage)
label var Maturity "Program age"

* Education level
replace Yearlevel = "Primary" if Yearlevel == "Middle School" | Yearlevel == "Elementary"
replace Yearlevel = "Secondary" if Yearlevel == "High School" | Yearlevel == "High school"

* Performance Monitoring
gen Accountability = "With accountability" if Schoolaccountability!="N" & !missing(Schoolaccountability)
replace Accountability = "Without accountability" if Schoolaccountability=="N"
label var Accountability "Acountability mechanism"

* Generate Countrycode
* Generate a new variable for 3-digit ISO codes
gen countrycode = ""

* Assign ISO codes individually for each Country
replace countrycode = "ARG" if Country1 == "Argentina, Chile"
replace countrycode = "BGD" if Country1 == "Bangladesh"
replace countrycode = "CAN" if Country1 == "Canada"
replace countrycode = "CHL" if Country1 == "Chile"
replace countrycode = "COL" if Country1 == "Colombia"
replace countrycode = "DNK" if Country1 == "Denmark"
replace countrycode = "DEU" if Country1 == "Germany"
replace countrycode = "HTI" if Country1 == "Haiti"
replace countrycode = "HKG" if Country1 == "Hong Kong"
replace countrycode = "IND" if Country1 == "India"
replace countrycode = "KEN" if Country1 == "Kenya"
replace countrycode = "LVA" if Country1 == "Latvia"
replace countrycode = "LBR" if Country1 == "Liberia"
replace countrycode = "NLD" if Country1 == "Netherlands"
replace countrycode = "PAK" if Country1 == "Pakistan"
replace countrycode = "PHL" if Country1 == "Philippines"
replace countrycode = "SLE" if Country1 == "Sierra Leone"
replace countrycode = "SWE" if Country1 == "Sweden"
replace countrycode = "CHE" if Country1 == "Switzerland"
replace countrycode = "GBR" if Country1 == "UK"
replace countrycode = "USA" if Country1 == "US"
replace countrycode = "UGA" if Country1 == "Uganda"
replace countrycode = "VEN" if Country1 == "Venezuela"
replace countrycode = "VEN" if Country1 == "Venezuela, Colombia & Peru"

drop _merge Country
preserve
* Extract GDP values to calculate deflator
*  NY.GDP.PCAP.CD   (current) and NY.GDP.PCAP.PP.KD   (Constant)
* Countries: Canada, Chile, Denmark, Netherlands, Pakistan, Sweden, Colombia, US and UK
wbopendata, indicator("NY.GDP.MKTP.PP.KD")  year(1998:2023) clear
reshape long yr, i(countrycode) j(year)
rename yr gdp_ppp
tempfile gdppp
save `gdppp'

wbopendata, indicator("NY.GDP.MKTP.CD")  year(1998:2023) clear
reshape long yr, i(countrycode) j(year)
rename yr gdp_current
merge countrycode year using `gdppp'

gen gdp_deflator = gdp_ppp/gdp_current
keep countrycode year gdp_deflator 
rename year Year
save `gdppp', replace
restore

merge m:1 countrycode Year using `gdppp', keep(master match) 

* Create PPP cost in PPP USD 
gen ppp_cost_comp = PPPcostUSD * gdp_deflator
gen public_cost_comp = Publicschoolcostperpupil * gdp_deflator
gen cost_savings_comp = public_cost_comp - ppp_cost_comp



save "$directory/Merged-Data.dta", replace
