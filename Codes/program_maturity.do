
* Load the Excel file containing the datasets
global directory "/Users/angelosantos/Library/CloudStorage/OneDrive-GeorgeMasonUniversity-O365Production/School Choice/Datasets"

* Load data
use "$directory/Merged-Data.dta", clear

gen tstat = Effectsize/SEstd
gen sig = tstat >= 1.96  // 1 for significant, 0 for not significant (adjust threshold if needed)


twoway (scatter Effectsize Programage if sig == 1, msymbol(O) mcolor(blue)) ///
       (scatter Effectsize Programage if sig == 0, msymbol(O) mcolor(gs10)) ///
	   (lfit Effectsize Programage) if Programage!=99 & Programage<=15 , ///
       ylabel(, grid) xlabel(, grid) title("Effect Size by Program Maturity") ///
       xtitle("Program Maturity") ytitle("Effect Size")
